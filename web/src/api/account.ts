export const deleteUser = (username: string) => {
  fetch(`/api/user/send-remove-link?username=${username}`);
};
