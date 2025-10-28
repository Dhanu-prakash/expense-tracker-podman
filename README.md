# ExpenseHub - Developer-Friendly Expense Tracker

A beautiful, containerized expense tracking application built for developers. Track spending, visualize trends, and get AI-powered insights—all in a delightful interface optimized for Docker deployment.

![ExpenseHub](https://lovable.dev/opengraph-image-p98pqg.png)

## ✨ Features

- 🧾 **Smart Expense Tracking** - Quick entry with category-based organization
- 📊 **Visual Analytics** - Beautiful charts and graphs for spending insights
- 🤖 **AI-Powered Suggestions** - Get personalized budget recommendations via Lovable AI
- 🔐 **Secure Authentication** - Built-in user authentication with Lovable Cloud
- 🎨 **Beautiful Design** - Modern, minimalist UI with smooth animations
- 🐳 **Containerized** - Docker-ready for seamless deployment
- ⚡ **Real-time Updates** - Live data synchronization across devices

## 🚀 Quick Start

### Local Development

```bash
# Clone the repository
git clone <YOUR_GIT_URL>
cd <YOUR_PROJECT_NAME>

# Install dependencies
npm install

# Start development server
npm run dev
```

The app will be available at `http://localhost:8080`

### Docker Deployment

```bash
# Build the Docker image
docker build -t expensehub:latest .

# Run the container
docker run -d -p 8080:8080 \
  -e VITE_SUPABASE_URL=your_url \
  -e VITE_SUPABASE_PUBLISHABLE_KEY=your_key \
  --name expensehub \
  expensehub:latest
```

For detailed Docker and Red Hat OpenShift deployment instructions, see [DOCKER.md](./DOCKER.md).

## 🛠️ Technology Stack

- **Frontend**: React 18 + TypeScript + Vite
- **Styling**: Tailwind CSS + shadcn/ui components
- **Backend**: Lovable Cloud (Supabase)
- **AI**: Lovable AI (Google Gemini 2.5)
- **Charts**: Recharts
- **State Management**: TanStack Query
- **Containerization**: Docker + Nginx

## 📁 Project Structure

```
expensehub/
├── src/
│   ├── components/
│   │   ├── expenses/       # Expense-related components
│   │   └── ui/            # shadcn/ui components
│   ├── hooks/             # Custom React hooks
│   ├── pages/             # Route pages
│   └── integrations/      # Lovable Cloud integration
├── supabase/
│   └── functions/         # Backend edge functions
├── Dockerfile             # Container configuration
├── nginx.conf            # Nginx server config
└── DOCKER.md             # Docker deployment guide
```

## 🎯 Key Components

### Dashboard
The main hub displaying:
- Total expenses and budget status
- Spending trends (line chart)
- Category breakdown (pie chart)
- AI-powered insights

### Expense Management
- Quick add expense form with category selection
- Real-time expense list with edit/delete
- Date-based filtering
- Category-based organization

### AI Insights
Powered by Lovable AI (Google Gemini 2.5):
- Spending pattern analysis
- Budget alerts
- Personalized saving tips
- Smart recommendations

## 🔒 Security

- Row Level Security (RLS) policies on all database tables
- Secure authentication via Lovable Cloud
- Environment-based configuration
- No sensitive data in codebase

## 🌐 Deployment

### Lovable Deployment

1. Open the project in [Lovable](https://lovable.dev/projects/7b22fd1e-a0a0-46f3-8917-727569604cf0)
2. Click Share → Publish
3. Your app is live!

### Docker Deployment

See [DOCKER.md](./DOCKER.md) for comprehensive Docker and OpenShift deployment instructions.

### Custom Domain

Navigate to Project > Settings > Domains in Lovable to connect your custom domain.

## 🧪 Development

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## 📊 Database Schema

### Expenses Table
```sql
- id: UUID (Primary Key)
- user_id: UUID (Foreign Key)
- amount: DECIMAL(10,2)
- category: TEXT (food, transport, entertainment, etc.)
- description: TEXT
- date: DATE
- created_at: TIMESTAMP
- updated_at: TIMESTAMP
```

## 🤝 Contributing

This is a Lovable project! You can contribute by:
1. Forking/remixing the project in Lovable
2. Making changes via prompts or code
3. Sharing your improvements

## 📖 Documentation

- [Lovable Documentation](https://docs.lovable.dev/)
- [Lovable Cloud Features](https://docs.lovable.dev/features/cloud)
- [Lovable AI Integration](https://docs.lovable.dev/features/ai)
- [Docker Deployment Guide](./DOCKER.md)

## 💡 Tips for Best Experience

1. **Add Expenses Regularly** - More data = better AI insights
2. **Use Categories** - Helps track spending patterns
3. **Generate AI Insights** - Click the button after adding expenses
4. **Set a Budget** - Currently set to $3,500/month (customizable)
5. **Check Charts** - Visual data helps identify trends

## 🐛 Troubleshooting

### Can't see expenses?
- Make sure you're logged in
- Check that RLS policies are enabled
- Verify Lovable Cloud connection

### AI insights not working?
- Ensure you have expenses added
- Check Lovable AI credit balance
- Verify backend function is deployed

### Docker issues?
- See [DOCKER.md](./DOCKER.md) troubleshooting section
- Check container logs: `docker logs expensehub`

## 📄 License

This project was generated with [Lovable](https://lovable.dev) and is open for personal and commercial use.

## 🙏 Credits

Built with:
- [Lovable](https://lovable.dev) - The AI-powered app builder
- [shadcn/ui](https://ui.shadcn.com/) - Beautiful UI components
- [Supabase](https://supabase.com/) - Backend infrastructure
- [Tailwind CSS](https://tailwindcss.com/) - Styling framework

---

Made with ❤️ for developers who love beautiful, functional apps
