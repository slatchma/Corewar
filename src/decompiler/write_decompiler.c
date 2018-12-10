/* ************************************************************************** */
/*                                                          LE - /            */
/*                                                              /             */
/*   write_decompiler.c                               .::    .:/ .      .::   */
/*                                                 +:+:+   +:    +:  +:+:+    */
/*   By: slatchma <marvin@le-101.fr>                +:+   +:    +:    +:+     */
/*                                                 #+#   #+    #+    #+#      */
/*   Created: 2018/12/08 22:18:18 by slatchma     #+#   ##    ##    #+#       */
/*   Updated: 2018/12/08 22:18:44 by slatchma    ###    #+. /#+    ###.fr     */
/*                                                         /                  */
/*                                                        /                   */
/* ************************************************************************** */

#include "decompiler.h"

static int	ft_neg_nbre(char type, int nbre)
{
	long	limit;
	long	max;

	limit = 0;
	if (type == 'R')
	{
		limit = 0x80;
		max = 0xFF;
	}
	if (type == 'I' || type == 'd')
	{
		limit = 0x8000;
		max = 0xFFFF;
	}
	else
	{
		limit = 0x80000000;
		max = 0xFFFFFFFF;
	}
	if ((long)nbre >= limit)
		nbre = nbre - max - 1;
	return (nbre);
}

static int	ft_write_param_dec(int fdout, char type, int nbre)
{
	char *string_nbre;

	string_nbre = NULL;
	if (type == 0)
		return (0);
	if (type == 'R')
		write(fdout, "r", 1);
	if (type == 'D' || type == 'd')
		write(fdout, "%", 1);
	nbre = (ft_neg_nbre(type, nbre));
	string_nbre = ft_itoa(nbre);
	write(fdout, string_nbre, ft_strlen(string_nbre));
	ft_strdel(&string_nbre);
	return (0);
}

static void	ft_write_op(int fdout, char *op)
{
	write(fdout, op, ft_strlen(op));
	if (ft_strlen(op) > 3)
		write(fdout, "\t", 1);
	else
		write(fdout, "\t\t", 2);
}

void		ft_write_dec_body(int fdout, t_analyze myoctet)
{
	int		i;
	t_op	*op;

	i = 0;
	op = get_op_tab();
	while (i < 16)
	{
		if (op[i].bin == myoctet.opcode)
			ft_write_op(fdout, op[i].op);
		i++;
	}
	ft_write_param_dec(fdout, myoctet.param1_type, myoctet.param1_nbre);
	if (myoctet.param2_type != 0)
	{
		write(fdout, ", ", 2);
		ft_write_param_dec(fdout, myoctet.param2_type, myoctet.param2_nbre);
	}
	if (myoctet.param3_type != 0)
	{
		write(fdout, ", ", 2);
		ft_write_param_dec(fdout, myoctet.param3_type, myoctet.param3_nbre);
	}
}
