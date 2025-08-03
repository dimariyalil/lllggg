import React from 'react'
import { Upload, Search, Filter, Download } from 'lucide-react'

const channels = [
  { name: '@betting_pro', subs: '125K', er: '3.2%', cpm: '$45', score: 8.5 },
  { name: '@casino_vip', subs: '89K', er: '4.1%', cpm: '$38', score: 9.2 },
  { name: '@slots_club', subs: '67K', er: '2.9%', cpm: '$52', score: 7.8 },
]

export default function TgAnalytics() {
  return (
    <div>
      <div className="mb-8">
        <h2 className="text-3xl font-bold">Telegram Analytics</h2>
        <p className="text-gray-400 mt-2">Analyze and optimize your Telegram marketing</p>
      </div>

      <div className="flex flex-wrap gap-4 mb-8">
        <button className="btn-primary flex items-center">
          <Upload className="mr-2 h-4 w-4" />
          Upload Channels
        </button>
        <button className="btn-primary flex items-center">
          <Search className="mr-2 h-4 w-4" />
          Search
        </button>
        <button className="btn-primary flex items-center">
          <Filter className="mr-2 h-4 w-4" />
          Filter
        </button>
      </div>

      <div className="card mb-8">
        <h3 className="text-xl font-semibold mb-4">Your Channels</h3>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-dark-border">
                <th className="text-left py-3 px-4">Channel</th>
                <th className="text-left py-3 px-4">Subscribers</th>
                <th className="text-left py-3 px-4">ER%</th>
                <th className="text-left py-3 px-4">CPM</th>
                <th className="text-left py-3 px-4">Score</th>
                <th className="text-left py-3 px-4">Action</th>
              </tr>
            </thead>
            <tbody>
              {channels.map((channel) => (
                <tr key={channel.name} className="border-b border-dark-border/50">
                  <td className="py-3 px-4 font-medium">{channel.name}</td>
                  <td className="py-3 px-4">{channel.subs}</td>
                  <td className="py-3 px-4">{channel.er}</td>
                  <td className="py-3 px-4">{channel.cpm}</td>
                  <td className="py-3 px-4"><span className="text-primary-500 font-medium">{channel.score}</span></td>
                  <td className="py-3 px-4"><button className="text-primary-500 hover:text-primary-400 text-sm">Analyze</button></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="card">
        <h3 className="text-xl font-semibold mb-4">Competitor Analysis</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-primary-500">67%</p>
            <p className="text-sm text-gray-400 mt-1">Audience Overlap</p>
          </div>
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-green-500">23</p>
            <p className="text-sm text-gray-400 mt-1">Untapped Channels</p>
          </div>
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-yellow-500">+45%</p>
            <p className="text-sm text-gray-400 mt-1">Traffic Potential</p>
          </div>
        </div>
      </div>
    </div>
  )
}
