import pytest
from app.services.shortener import create_hash


def test_create_hash_returns_string():
    test_id = 1

    result = create_hash(test_id)

    assert isinstance(result, str)
    assert len(result) > 0


def test_create_hash_fails_on_invalid_input():
    with pytest.raises(TypeError):
        create_hash("This is not an int")