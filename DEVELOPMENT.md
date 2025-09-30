# Development Guide

> **Note**: This is a template file. When creating a new repository, copy this file and customize it for your specific project.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js**: [Version X.X or higher](https://nodejs.org/)
- **pnpm**: [Version X.X or higher](https://pnpm.io/)
- **Git**: [Latest version](https://git-scm.com/)
- **[Other tools]**: Links and versions

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/benhigham/[repository-name].git
   cd [repository-name]
   ```

2. **Install dependencies**

   ```bash
   pnpm install
   ```

3. **Set up environment variables**

   ```bash
   cp .env.example .env
   # Edit .env with your local configuration
   ```

4. **Run database migrations** (if applicable)

   ```bash
   pnpm run db:migrate
   ```

5. **Start the development server**

   ```bash
   pnpm run dev
   ```

The application should now be running at `http://localhost:3000`.

## Project Structure

```
.
├── src/                    # Source code
│   ├── components/        # Reusable components
│   ├── pages/            # Page components
│   ├── utils/            # Utility functions
│   ├── hooks/            # Custom hooks
│   ├── services/         # API services
│   ├── types/            # TypeScript type definitions
│   └── config/           # Configuration files
├── tests/                 # Test files
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── e2e/              # End-to-end tests
├── public/               # Static assets
├── docs/                 # Documentation
└── scripts/              # Build and utility scripts
```

## Available Scripts

### Development

- `pnpm run dev` - Start development server with hot reload
- `pnpm run dev:debug` - Start development server with debugging enabled
- `pnpm run dev:inspect` - Start development server with Node.js inspector

### Building

- `pnpm run build` - Build for production
- `pnpm run build:analyze` - Build and analyze bundle size
- `pnpm run build:preview` - Build and preview production build locally

### Testing

- `pnpm run test` - Run all tests
- `pnpm run test:unit` - Run unit tests
- `pnpm run test:integration` - Run integration tests
- `pnpm run test:e2e` - Run end-to-end tests
- `pnpm run test:watch` - Run tests in watch mode
- `pnpm run test:coverage` - Run tests with coverage report

### Code Quality

- `pnpm run lint` - Run ESLint
- `pnpm run lint:fix` - Run ESLint and fix auto-fixable issues
- `pnpm run format` - Format code with Prettier
- `pnpm run format:check` - Check code formatting
- `pnpm run typecheck` - Run TypeScript type checking

### Database (if applicable)

- `pnpm run db:migrate` - Run database migrations
- `pnpm run db:seed` - Seed the database
- `pnpm run db:reset` - Reset the database
- `pnpm run db:studio` - Open database studio

## Development Workflow

### 1. Pick an Issue

- Browse [open issues](https://github.com/benhigham/[repository-name]/issues)
- Look for issues labeled `good first issue` if you're new
- Comment on the issue to let others know you're working on it

### 2. Create a Branch

```bash
git checkout -b feat/issue-123-add-new-feature
```

Branch naming conventions:

- `feat/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests
- `chore/` - Maintenance tasks

### 3. Make Your Changes

- Write clean, readable code
- Follow the existing code style
- Add tests for new functionality
- Update documentation as needed

### 4. Test Your Changes

```bash
# Run linting
pnpm run lint

# Run type checking
pnpm run typecheck

# Run tests
pnpm run test

# Build the project
pnpm run build
```

### 5. Commit Your Changes

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug in component"
git commit -m "docs: update README"
```

Commit types:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `perf:` - Performance improvements
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks
- `ci:` - CI/CD changes

### 6. Push and Create PR

```bash
git push origin feat/issue-123-add-new-feature
```

Then create a pull request on GitHub.

## Code Style Guide

### TypeScript

- Use TypeScript strict mode
- Prefer `interface` over `type` for object types
- Use explicit return types for functions
- Avoid `any` - use `unknown` if type is truly unknown

### Naming Conventions

- **Files**: kebab-case (`my-component.tsx`)
- **Components**: PascalCase (`MyComponent`)
- **Functions**: camelCase (`handleClick`)
- **Constants**: UPPER_SNAKE_CASE (`API_BASE_URL`)
- **Types/Interfaces**: PascalCase (`UserProfile`)

### Component Structure

```typescript
// 1. Imports
import { useState } from 'react';
import { Button } from './button';

// 2. Types
interface MyComponentProps {
  title: string;
  onAction: () => void;
}

// 3. Component
export function MyComponent({ title, onAction }: MyComponentProps) {
  // 4. Hooks
  const [state, setState] = useState(false);

  // 5. Event handlers
  const handleClick = () => {
    setState(true);
    onAction();
  };

  // 6. Render
  return (
    <div>
      <h1>{title}</h1>
      <Button onClick={handleClick}>Click me</Button>
    </div>
  );
}
```

## Testing Guidelines

### Unit Tests

- Test individual functions and components in isolation
- Use descriptive test names
- Follow AAA pattern: Arrange, Act, Assert

```typescript
describe('MyComponent', () => {
  it('should render the title', () => {
    // Arrange
    const title = 'Hello World';
    
    // Act
    const { getByText } = render(<MyComponent title={title} />);
    
    // Assert
    expect(getByText(title)).toBeInTheDocument();
  });
});
```

### Integration Tests

- Test how multiple components work together
- Mock external dependencies
- Focus on user workflows

### E2E Tests

- Test critical user journeys
- Run against production-like environment
- Keep tests independent and isolated

## Debugging

### VS Code Debug Configuration

Add to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Dev Server",
      "runtimeExecutable": "pnpm",
      "runtimeArgs": ["run", "dev:debug"],
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

### Browser DevTools

- Use React DevTools for component inspection
- Use Redux DevTools for state management debugging
- Use Network tab for API debugging

### Common Issues

#### Issue 1: [Description]

**Solution**: [How to fix it]

#### Issue 2: [Description]

**Solution**: [How to fix it]

## Performance Optimization

### Development Performance

- Use `React.memo()` for expensive components
- Implement proper dependency arrays in `useEffect`
- Use `useMemo()` and `useCallback()` appropriately

### Build Performance

- Analyze bundle size regularly
- Use dynamic imports for code splitting
- Optimize images and assets

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `API_URL` | Backend API URL | Yes | - |
| `NODE_ENV` | Environment | No | `development` |
| `PORT` | Server port | No | `3000` |

## Database Development

### Migrations

```bash
# Create a new migration
pnpm run db:migration:create add_users_table

# Run migrations
pnpm run db:migrate

# Rollback last migration
pnpm run db:migrate:rollback
```

### Seeding

```bash
# Seed the database
pnpm run db:seed

# Seed specific seeder
pnpm run db:seed:run users
```

## API Development

### Adding New Endpoints

1. Define the route in `src/routes/`
2. Create controller in `src/controllers/`
3. Add validation schema
4. Write tests
5. Update API documentation

### API Testing

Use tools like:

- **Postman**: For manual API testing
- **Insomnia**: For REST and GraphQL testing
- **curl**: For quick command-line testing

## Documentation

### Code Documentation

- Add JSDoc comments for public APIs
- Document complex logic with inline comments
- Keep README up to date

### API Documentation

- Use OpenAPI/Swagger for REST APIs
- Use GraphQL schema for GraphQL APIs
- Keep examples up to date

## Resources

- [Project Wiki](https://github.com/benhigham/[repository-name]/wiki)
- [API Documentation](https://api.example.com/docs)
- [Design System](https://design.example.com)
- [Contributing Guidelines](CONTRIBUTING.md)

## Getting Help

- **GitHub Discussions**: [Ask questions](https://github.com/benhigham/[repository-name]/discussions)
- **Issue Tracker**: [Report bugs](https://github.com/benhigham/[repository-name]/issues)
- **Discord/Slack**: [Join the community](#)

## License

This project is licensed under the [LICENSE NAME] - see the [LICENSE.md](LICENSE.md) file for details.
