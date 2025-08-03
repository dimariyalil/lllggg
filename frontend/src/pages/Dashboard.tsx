import React from 'react'
import { TrendingUp, TrendingDown, Users, DollarSign, Activity } from 'lucide-react'
import { Link } from 'react-router-dom'

const metrics = [
  { name: 'Revenue', value: '$125,430', change: '+12%', trend: 'up', icon: DollarSign },
  { name: 'Active Users', value: '8,234', change: '+5%', trend: 'up', icon: Users },
  { name: 'Burn Rate', value: '-$45,000', change: '-8%', trend: 'down', icon: Activity },
]

export default function Dashboard() {
  return (
    <div>
      <div className="mb-8">
        <h2 className="text-3xl font-bold">CEO Dashboard</h2>
        <p className="text-gray-400 mt-2">Welcome back! Here's your command center</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        {metrics.map((metric) => (
          <div key={metric.name} className="metric-card">
            <div className="flex items-center justify-between mb-4">
              <metric.icon className="h-8 w-8 text-primary-500" />
              <span className={`flex items-center text-sm font-medium ${
                metric.trend === 'up' ? 'text-green-500' : 'text-red-500'
              }`}>
                {metric.change}
                {metric.trend === 'up' ? <TrendingUp className="ml-1 h-4 w-4" /> : <TrendingDown className="ml-1 h-4 w-4" />}
              </span>
            </div>
            <p className="text-2xl font-bold">{metric.value}</p>
            <p className="text-gray-400 text-sm mt-1">{metric.name}</p>
          </div>
        ))}
      </div>

      <div className="card mb-8">
        <h3 className="text-xl font-semibold mb-4">Quick Actions</h3>
        <div className="flex flex-wrap gap-4">
          <Link to="/ceo-tasks" className="btn-primary">View CEO Tasks</Link>
          <Link to="/tg-analytics" className="btn-primary">TG Analytics</Link>
          <Link to="/ai-chat" className="btn-primary">AI Analysis</Link>
        </div>
      </div>

      <div className="card">
        <h3 className="text-xl font-semibold mb-4">21 CEO Tasks Progress</h3>
        <div className="mb-4">
          <div className="flex justify-between text-sm mb-2">
            <span>Overall Progress</span>
            <span className="font-medium">35% Complete</span>
          </div>
          <div className="w-full bg-dark-border rounded-full h-3">
            <div className="bg-primary-600 h-3 rounded-full" style={{ width: '35%' }}></div>
          </div>
        </div>
        <Link to="/ceo-tasks" className="text-primary-500 hover:text-primary-400 text-sm font-medium">
          View All Tasks →
        </Link>
      </div>
    </div>
  )
}
