import { ButtonHTMLAttributes, DetailedHTMLProps } from 'react';

interface IProps
  extends DetailedHTMLProps<
    ButtonHTMLAttributes<HTMLButtonElement>,
    HTMLButtonElement
  > {
  size?: string;
}

export const Button = ({ size, className, ...props }: IProps) => (
  <button className={`${size && `size-${size}`} ${className}`} {...props} />
);
