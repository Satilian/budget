import s from './s.module.css';

export const DeleteUserPending = () => {
  return (
    <div className={s.container}>
      <h2>Request sent</h2>

      <p>
        You have requested to delete your account. To confirm, please follow the
        link sent to the corresponding email address.
      </p>
    </div>
  );
};
