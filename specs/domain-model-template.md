# Domain Model Specification (Template)

## Overview

This document defines the core domain entities and their relationships.

## Entities

### Entity: [EntityName]

**Purpose**: [What does this entity represent?]

**Fields**:

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| id | string | Yes | Non-empty, unique | Unique identifier |
| name | string | Yes | Non-empty, max 100 chars | Display name |
| quantity | integer | Yes | > 0 | Amount |
| price | decimal | No | >= 0 | Price in dollars |
| status | enum | Yes | NEW, ACTIVE, DONE | Current status |
| created_at | datetime | Yes | Auto-set | Creation timestamp |

**Validation Rules**:
1. `id` must be non-empty
2. `quantity` must be positive
3. `price` (if present) must be non-negative
4. `name` must be non-empty and <= 100 characters

**Example**:
```json
{
  "id": "ENT-001",
  "name": "Example Entity",
  "quantity": 100,
  "price": 25.50,
  "status": "NEW",
  "created_at": "2024-01-15T10:30:00Z"
}
```

**Code Representation**:
```[language]
// Example in Python
from dataclasses import dataclass
from decimal import Decimal
from datetime import datetime
from enum import Enum

class Status(Enum):
    NEW = "NEW"
    ACTIVE = "ACTIVE"
    DONE = "DONE"

@dataclass(frozen=True)
class EntityName:
    id: str
    name: str
    quantity: int
    status: Status
    created_at: datetime
    price: Decimal | None = None

    def __post_init__(self):
        if not self.id:
            raise ValueError("id cannot be empty")
        if not self.name:
            raise ValueError("name cannot be empty")
        if len(self.name) > 100:
            raise ValueError("name must be <= 100 characters")
        if self.quantity <= 0:
            raise ValueError("quantity must be positive")
        if self.price is not None and self.price < 0:
            raise ValueError("price must be non-negative")
```

---

### Entity: [AnotherEntity]

[Repeat the pattern above]

---

## Value Objects

### Value Object: [ValueName]

**Purpose**: [What does this value object represent?]

**Fields**:

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| field1 | type | constraint | description |

**Equality**: Two [ValueName] objects are equal if all fields match.

**Code Representation**:
```[language]
// Example
@dataclass(frozen=True)
class ValueName:
    field1: str
    field2: int
```

---

## Enumerations

### Enum: [EnumName]

**Purpose**: [What does this enum represent?]

**Values**:

| Value | Description |
|-------|-------------|
| VALUE1 | Description of value 1 |
| VALUE2 | Description of value 2 |
| VALUE3 | Description of value 3 |

**Code Representation**:
```[language]
class EnumName(Enum):
    VALUE1 = "VALUE1"
    VALUE2 = "VALUE2"
    VALUE3 = "VALUE3"
```

---

## Relationships

### [Entity1] → [Entity2]

**Type**: [One-to-One | One-to-Many | Many-to-Many]
**Description**: [How are they related?]

Example:
> An Order has many Fills. Each Fill belongs to exactly one Order.

---

## State Transitions

### [EntityName] Status Transitions

```
      ┌─────┐
      │ NEW │
      └──┬──┘
         │ activate()
         ▼
    ┌────────┐
    │ ACTIVE │
    └───┬────┘
        │ complete()
        ▼
    ┌──────┐
    │ DONE │
    └──────┘
```

**Valid Transitions**:
| From | To | Trigger |
|------|-----|---------|
| NEW | ACTIVE | activate() |
| ACTIVE | DONE | complete() |

**Invalid Transitions** (should raise error):
- DONE → NEW
- DONE → ACTIVE
- NEW → DONE (must go through ACTIVE)

---

## Invariants

1. **[Invariant Name]**: [Description]
   - Example: "Cumulative quantity never exceeds order quantity"

2. **[Invariant Name]**: [Description]
   - Example: "Filled orders have zero remaining quantity"

---

## Test Cases

For each entity, the following tests should exist:

### [EntityName] Tests

1. `test_should_create_valid_entity` - Create with all valid fields
2. `test_should_reject_empty_id` - Empty id raises ValueError
3. `test_should_reject_negative_quantity` - Negative quantity raises ValueError
4. `test_should_be_immutable` - Fields cannot be changed after creation
5. `test_should_calculate_derived_fields` - Computed properties work correctly
