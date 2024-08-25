import {
  DeleteUserForm,
  DeleteUserFullfilled,
  DeleteUserPending,
} from 'components';
import { useSearchParams } from 'react-router-dom';

export const UserDelete = () => {
  const [params] = useSearchParams();
  const state = params.get('state');

  if (state === 'pending') {
    return <DeleteUserPending />;
  }

  if (state === 'fullfilled') {
    return <DeleteUserFullfilled />;
  }

  return <DeleteUserForm />;
};
