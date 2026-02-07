# Testing Strategy Specification (Template)

## Overview

This document outlines the testing strategy. Following Test-First Development (TDD), all tests must be written BEFORE implementation code.

## Testing Pyramid

```
        /\
       /  \      E2E Tests (5%)
      /____\     - Full system tests
     /      \
    /        \   Integration Tests (15%)
   /__________\  - Component integration
  /            \
 /              \ Unit Tests (80%)
/________________\ - Individual classes/functions
```

## Test-First Workflow

For EVERY feature:

1. **Write failing test** - RED
2. **Run test** - See it fail
3. **Write minimal code** - Make it pass
4. **Run test** - GREEN
5. **Refactor** - Clean up
6. **Repeat**

## Unit Tests

### Naming Convention

Test names should follow this pattern:
```
test_should_[expected_behavior]_when_[condition]
```

Examples:
- `test_should_create_valid_order`
- `test_should_reject_negative_quantity`
- `test_should_return_empty_for_unknown_id`

### Test Structure (AAA Pattern)

```[language]
def test_should_do_something():
    # Arrange - Set up test data
    entity = Entity(field1="value")

    # Act - Perform the action
    result = entity.some_method()

    # Assert - Verify the result
    assert result == expected_value
```

### Domain Model Tests

**[EntityName] Tests** (`test_[entity].ext`):

```[language]
# Required tests for every entity:

def test_should_create_valid_entity():
    # Test creation with all valid fields
    pass

def test_should_reject_empty_required_field():
    # Test each required field
    pass

def test_should_reject_invalid_values():
    # Test validation rules (negative numbers, etc.)
    pass

def test_should_be_immutable():
    # Test that fields cannot be modified
    pass

def test_should_implement_equality():
    # Test __eq__ and __hash__
    pass
```

### Service/Engine Tests

**[ServiceName] Tests** (`test_[service].ext`):

```[language]
def test_should_process_valid_input():
    pass

def test_should_reject_invalid_input():
    pass

def test_should_handle_edge_cases():
    pass

def test_should_return_correct_result():
    pass
```

## Integration Tests

### Component Integration

Test that components work together correctly:

```[language]
def test_should_process_from_start_to_finish():
    # Create real instances (not mocks)
    transport = InMemoryTransport()
    engine = Engine(transport)

    # Submit through the full pipeline
    result = engine.process(input_data)

    # Verify end-to-end
    assert result.status == "COMPLETE"
```

## Mocking Strategy

### When to Mock

- External services (APIs, databases)
- Time-dependent operations
- Random number generation
- File system operations

### When NOT to Mock

- Domain objects
- Pure functions
- Value objects

### Mock Example

```[language]
def test_should_call_external_service(mocker):
    # Arrange
    mock_service = mocker.Mock()
    mock_service.fetch.return_value = {"data": "value"}

    processor = Processor(external_service=mock_service)

    # Act
    result = processor.process()

    # Assert
    mock_service.fetch.assert_called_once()
    assert result == expected
```

## Test Data

### Test Fixtures

Create reusable test data:

```[language]
# fixtures.py or conftest.py

def valid_entity():
    return Entity(
        id="TEST-001",
        name="Test Entity",
        quantity=100
    )

def invalid_entity_data():
    return {
        "id": "",  # Invalid: empty
        "name": "Test",
        "quantity": -1  # Invalid: negative
    }
```

### Factory Functions

```[language]
def create_entity(
    id: str = "TEST-001",
    name: str = "Test",
    quantity: int = 100,
    **overrides
) -> Entity:
    return Entity(
        id=id,
        name=name,
        quantity=quantity,
        **overrides
    )
```

## Coverage Goals

| Component | Target | Rationale |
|-----------|--------|-----------|
| Domain Models | 95%+ | Core logic must be thoroughly tested |
| Services/Engine | 90%+ | Business logic is critical |
| Transport | 80%+ | Less critical, interface-focused |
| Overall | 80%+ | Industry standard |

## Test Commands

```bash
# Run all tests
[test command]

# Run specific test file
[test specific file command]

# Run tests matching pattern
[test pattern command]

# Run with coverage
[coverage command]

# Generate coverage report
[coverage report command]
```

## Continuous Integration

Tests should run on every commit:

1. Run linter
2. Run unit tests
3. Run integration tests
4. Generate coverage report
5. Fail if coverage < 80%

## Performance Tests (Optional)

For performance-critical code:

```[language]
def test_should_process_1000_items_in_under_1_second():
    items = [create_item() for _ in range(1000)]

    start = time.time()
    processor.process_all(items)
    elapsed = time.time() - start

    assert elapsed < 1.0, f"Took {elapsed}s, expected < 1s"
```

## Best Practices

1. **One assertion per test** (when possible)
2. **Descriptive names**: `test_should_reject_order_with_negative_quantity`
3. **Fast tests**: Unit tests < 100ms each
4. **Isolated tests**: No shared state between tests
5. **Repeatable tests**: Same result every time
6. **Test edge cases**: Nulls, empty, boundaries, max values
7. **Test error paths**: Exceptions, failures, error messages
8. **Clean up**: Reset state after each test

## TDD Example

```[language]
# Step 1: RED - Write failing test
def test_should_reject_negative_quantity():
    with pytest.raises(ValueError, match="Quantity must be positive"):
        Entity(id="E-001", name="Test", quantity=-100)

# Step 2: Run test - IT FAILS ✗

# Step 3: GREEN - Write minimal code
class Entity:
    def __init__(self, id: str, name: str, quantity: int):
        if quantity <= 0:
            raise ValueError("Quantity must be positive")
        self.id = id
        self.name = name
        self.quantity = quantity

# Step 4: Run test - IT PASSES ✓

# Step 5: REFACTOR - Clean up if needed
```
