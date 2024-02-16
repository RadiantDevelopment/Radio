import React from 'react'
import ReactDOM from 'react-dom/client'

import { Radio } from './components/Radio/Radio'

import "./template.less"

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <Radio />
  </React.StrictMode>,
)