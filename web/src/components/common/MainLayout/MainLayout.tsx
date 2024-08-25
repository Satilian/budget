import { Outlet } from 'react-router';
import { Link, NavLink } from 'react-router-dom';
import logo from 'assets/logo.png';
import s from './s.module.css';

export const MainLayout = () => {
  return (
    <div className={s.container}>
      <div className={s.head}>
        <Link to="/" style={{ display: 'flex' }}>
          <div className={s.logo}>
            <img src={logo} alt="" />
          </div>
          <h1>Family budget</h1>
        </Link>
      </div>

      <Outlet />

      <div className={s.footer}>
        <NavLink
          to="/privacy-policy"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Privacy Policy
        </NavLink>

        <NavLink
          to="/user-delete"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          User delete
        </NavLink>
      </div>
    </div>
  );
};
