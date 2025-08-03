import React from 'react'
import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import CeoTasks from './pages/CeoTasks'
import TgAnalytics from './pages/TgAnalytics'
import AiChat from './pages/AiChat'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Dashboard />} />
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="ceo-tasks" element={<CeoTasks />} />
        <Route path="tg-analytics" element={<TgAnalytics />} />
        <Route path="ai-chat" element={<AiChat />} />
      </Route>
    </Routes>
  )
}

export default App
