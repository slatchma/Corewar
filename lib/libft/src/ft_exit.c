/* ************************************************************************** */
/*                                                          LE - /            */
/*                                                              /             */
/*   ft_exit.c                                        .::    .:/ .      .::   */
/*                                                 +:+:+   +:    +:  +:+:+    */
/*   By: fblin <fblin@student.le-101.fr>            +:+   +:    +:    +:+     */
/*                                                 #+#   #+    #+    #+#      */
/*   Created: 2016/01/27 15:16:57 by fblin        #+#   ##    ##    #+#       */
/*   Updated: 2018/01/26 14:47:14 by fablin      ###    #+. /#+    ###.fr     */
/*                                                         /                  */
/*                                                        /                   */
/* ************************************************************************** */

#include "libft.h"

void	ft_exit(char *err_message)
{
	ft_putendl_fd(err_message, STDERR);
	exit(1);
}
