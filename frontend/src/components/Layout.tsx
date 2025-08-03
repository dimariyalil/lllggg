import React from 'react'
import { Outlet, Link, useLocation } from 'react-router-dom'
import { LayoutDashboard, CheckSquare, BarChart3, MessageSquare, Menu, X } from 'lucide-react'

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'CEO Tasks', href: '/ceo-tasks', icon: CheckSquare },
  { name: 'TG Analytics', href: '/tg-analytics', icon: BarChart3 },
  { name: 'AI Chat', href: '/ai-chat', icon: MessageSquare },
]

export default function Layout() {
  const location = useLocation()
  const [sidebarOpen, setSidebarOpen] = React.useState(false)

  return (
    <div className="flex h-screen bg-dark-bg">
      <div className={`${sidebarOpen ? 'block' : 'hidden'} md:block md:w-64 bg-dark-card border-r border-dark-border`}>
        <div className="p-4">
          <h1 className="text-2xl font-bold text-primary-500">LILCOPILGIT</h1>
          <p className="text-sm text-gray-400 mt-1">AI-Powered Management</p>
        </div>
        <nav className="mt-8">
          {navigation.map((item) => {
            const isActive = location.pathname === item.href
            return (
              <Link
                key={item.name}
                to={item.href}
                className={`flex items-center px-4 py-3 text-sm font-medium transition-colors ${
                  isActive
                    ? 'bg-primary-900/20 text-primary-500 border-r-2 border-primary-500'
                    : 'text-gray-300 hover:bg-dark-border/50 hover:text-white'
                }`}
              >
                <item.icon className="mr-3 h-5 w-5" />
                {item.name}
              </Link>
            )
          })}
        </nav>
      </div>

      <div className="flex-1 flex flex-col overflow-hidden">
        <div className="md:hidden bg-dark-card border-b border-dark-border p-4 flex justify-between items-center">
          <h1 className="text-xl font-bold text-primary-500">LILCOPILGIT</h1>
          <button onClick={() => setSidebarOpen(!sidebarOpen)} className="text-gray-400 hover:text-white">
            {sidebarOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>
        <main className="flex-1 overflow-y-auto p-6">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
