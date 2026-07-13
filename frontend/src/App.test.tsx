import { render, screen } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import App from './App';

describe('App Component', () => {
  it('renders the main title', () => {
    render(<App />);
    const titleElement = screen.getByText(/Shortify - Shorten any link you want!/i);
    expect(titleElement).not.toBeNull();
  });

  it('renders the shorten button', () => {
    render(<App />);
    const buttonElement = screen.getByRole('button', { name: /Shortify!/i });
    expect(buttonElement).not.toBeNull();
  });
});