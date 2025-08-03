import React, { useState } from 'react'
import { Send, Bot, User } from 'lucide-react'

export default function AiChat() {
  const [message, setMessage] = useState('')
  const [messages, setMessages] = useState([
    { role: 'assistant', content: 'Hello! I\'m your AI assistant. How can I help you optimize your iGaming business today?' },
  ])

  const handleSend = () => {
    if (!message.trim()) return
    
    setMessages([...messages, { role: 'user', content: message }])
    setMessage('')
    
    setTimeout(() => {
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: 'I\'m analyzing your request. This feature will be connected to Claude API soon!',
      }])
    }, 1000)
  }

  return (
    <div className="flex flex-col h-full">
      <div className="mb-6">
        <h2 className="text-3xl font-bold">AI Assistant</h2>
        <p className="text-gray-400 mt-2">Get intelligent insights and recommendations</p>
      </div>

      <div className="flex-1 card flex flex-col">
        <div className="flex-1 overflow-y-auto mb-4 space-y-4">
          {messages.map((msg, index) => (
            <div key={index} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
              <div className={`flex items-start max-w-[70%] ${msg.role === 'user' ? 'flex-row-reverse' : ''}`}>
                <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center ${
                  msg.role === 'user' ? 'bg-primary-600 ml-2' : 'bg-gray-600 mr-2'
                }`}>
                  {msg.role === 'user' ? <User size={16} /> : <Bot size={16} />}
                </div>
                <div className={`px-4 py-2 rounded-lg ${
                  msg.role === 'user' ? 'bg-primary-600' : 'bg-dark-bg'
                }`}>
                  {msg.content}
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="flex gap-2">
          <input
            type="text"
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleSend()}
            placeholder="Type your message..."
            className="flex-1 bg-dark-bg border border-dark-border rounded-lg px-4 py-2 focus:outline-none focus:border-primary-500"
          />
          <button onClick={handleSend} className="btn-primary flex items-center">
            <Send size={20} />
          </button>
        </div>
      </div>
    </div>
  )
}
