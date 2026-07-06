from datetime import datetime
from pydantic import BaseModel, field_validator
import validators

class Url(BaseModel):
    full_url: str
    short_url: str
    created_at: datetime | None = None
    @field_validator('full_url')
    def check_full_url(cls, v):
        if v is None:
            raise ValueError('Url must not be None')
        else:
            if validators.domain(v):
                v = "https://" + v
                full_url = v
            if not validators.url(v):
                raise ValueError('Url must be a valid URL')
        return v

class Analytics(BaseModel):
    short_url: str
    click_time: datetime | None = None
    country: str | None = None
    browser: str | None = None