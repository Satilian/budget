import { FormEvent } from 'react';
import { Button } from 'components';
import s from './s.module.css';
import { deleteUser } from 'api';
import { useSearchParams } from 'react-router-dom';

export const DeleteUserForm = () => {
  const [params, setParams] = useSearchParams();

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const username = e.currentTarget['username']?.value;
    if (!username) return;

    deleteUser(username);

    params.append('state', 'pending');
    setParams(params);
  };

  return (
    <div className={s.container}>
      <h2>Deleting a user</h2>

      <p>
        To delete, enter your username and follow the link in the email you
        received. Warning! Recovery is not possible.
      </p>

      <form onSubmit={handleSubmit}>
        <input name="username" />

        <Button>delete</Button>
      </form>
    </div>
  );
};
