import React from 'react';
import { createRoot } from 'react-dom/client';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import { MainLayout } from 'components';
import { Home, PrivacyPolicy, UserDelete } from 'pages';
import './styles/styles.css';

const router = createBrowserRouter([
  {
    Component: MainLayout,
    path: '/',
    children: [
      {
        index: true,
        Component: Home,
      },
      {
        path: 'privacy-policy',
        Component: PrivacyPolicy,
      },
      {
        path: 'user-delete',
        Component: UserDelete,
      },
    ],
  },
]);

const rootEl = document.getElementById('root');

if (rootEl) {
  const root = createRoot(rootEl);

  root.render(
    <React.StrictMode>
      <RouterProvider router={router} />
    </React.StrictMode>,
  );
}
