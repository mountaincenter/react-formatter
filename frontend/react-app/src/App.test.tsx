import React from 'react';
import { render } from '@testing-library/react';
import App from './App';

describe('Appコンポーネント', () => {
  it('レンダリングが正常に行われるか', () => {
    const { getByText } = render(<App />);
    const headingElement = getByText('Hello World!');
    expect(headingElement).toBeInTheDocument();
  });
});
