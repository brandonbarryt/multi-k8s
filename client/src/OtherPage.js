import React from 'react';
import { Link } from 'react-router-dom';

export default () => {
  return (
    <div>
      I'm a Second Page for the FIB app: 
      <Link to="/">Go Back to Home Page!</Link>
    </div>
  );
};
