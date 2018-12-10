# ************************************************************************** #
#                                                          LE - /            #
#                                                              /             #
#   Makefile                                         .::    .:/ .      .::   #
#                                                 +:+:+   +:    +:  +:+:+    #
#   By: fablin <fablin@student.42.fr>              +:+   +:    +:    +:+     #
#                                                 #+#   #+    #+    #+#      #
#   Created: 2018/10/08 18:51:13 by fablin       #+#   ##    ##    #+#       #
#   Updated: 2018/12/05 15:40:21 by fablin      ###    #+. /#+    ###.fr     #
#                                                         /                  #
#                                                        /                   #
# ************************************************************************** #

COREWAR =	corewar

ASM		=	asm

DECOMP	=	decompiler

COR_SRC_DIR =	./src/corewar/

ASM_SRC_DIR =	./src/asm/

DEC_SRC_DIR =	./src/decompiler/

COR_OBJ_DIR =	./cor_obj/

ASM_OBJ_DIR =	./asm_obj/

DEC_OBJ_DIR =	./dec_obj/

COR_CFILES =	main.c				\
				exit.c

ASM_CFILES =	main.c				\
				exit.c				\
				lexer.c				\
				op.c				\
				arg_types.c			\
				utils.c 			\
				label.c				\
				lexer_ext_1.c		\
				lexer_ext_2.c 		\
				generator.c			\
				generator_header.c	\
				write_octet.c		\
				other.c				\
				generator_body.c	\
				lstlabel.c			\
				write_param.c		\
				secure_h.c

DEC_CFILES =	main.c				\
				fileout_cor.c		\
				analyze_octet.c		\
				op.c				\
				write_decompiler.c	\
				other.c				\
				secure_h.c

COR_SOURCES =	$(addprefix $(COR_SRC_DIR), $(COR_CFILES))

ASM_SOURCES =	$(addprefix $(ASM_SRC_DIR), $(ASM_CFILES))

DEC_SOURCES = 	$(addprefix $(DEC_SRC_DIR), $(DEC_CFILES))

COR_OFILES =	$(COR_CFILES:.c=.o)

ASM_OFILES =	$(ASM_CFILES:.c=.o)

DEC_OFILES =	$(DEC_CFILES:.c=.o)

COR_OBJECTS =	$(addprefix $(COR_OBJ_DIR), $(COR_OFILES))

ASM_OBJECTS =	$(addprefix $(ASM_OBJ_DIR), $(ASM_OFILES))

DEC_OBJECTS =	$(addprefix $(DEC_OBJ_DIR), $(DEC_OFILES))

FLAGS =		-Wall -Wextra -Werror

INC_DIR =	./inc/

all : libft obj $(COREWAR) $(ASM) $(DECOMP)

$(COREWAR) : $(COR_OBJECTS)
	gcc $(FLAGS) $(COR_OBJECTS) -L ./lib/libft/ -lft -o $(COREWAR)

$(ASM) : $(ASM_OBJECTS)
	gcc $(FLAGS) $(ASM_OBJECTS) -L ./lib/libft/ -lft -o $(ASM)

$(DECOMP) : $(DEC_OBJECTS)
	gcc $(FLAGS) $(DEC_OBJECTS) -L ./lib/libft/ -lft -o $(DECOMP)

$(COR_OBJ_DIR)%.o : $(COR_SRC_DIR)%.c
	gcc $(FLAGS) -c $< -o $@ -I $(INC_DIR) -I ./lib/libft/inc/

$(ASM_OBJ_DIR)%.o : $(ASM_SRC_DIR)%.c
	gcc $(FLAGS) -c $< -o $@ -I $(INC_DIR) -I ./lib/libft/inc/

$(DEC_OBJ_DIR)%.o : $(DEC_SRC_DIR)%.c
	gcc $(FLAGS) -c $< -o $@ -I $(INC_DIR) -I ./lib/libft/inc/

libft :
	@make -C ./lib/libft

obj :
	@mkdir -p $(COR_OBJ_DIR)
	@mkdir -p $(ASM_OBJ_DIR)
	@mkdir -p $(DEC_OBJ_DIR)

clean : obj
	@make clean -C ./lib/libft/
	@rm -rf $(COR_OBJ_DIR)
	@rm -rf $(ASM_OBJ_DIR)
	@rm -rf $(DEC_OBJ_DIR)

fclean : obj
	@make fclean -C ./lib/libft/
	@rm -f $(COREWAR) $(ASM) $(DECOMP)
	@rm -rf $(COR_OBJ_DIR)
	@rm -rf $(ASM_OBJ_DIR)
	@rm -rf $(DEC_OBJ_DIR)

re :
	@make re -C ./lib/libft/
	@rm -f $(COREWAR) $(ASM) $(DECOMP)
	@rm -rf $(COR_OBJ_DIR)
	@rm -rf $(ASM_OBJ_DIR)
	@rm -rf $(DEC_OBJ_DIR)
	@make

install :
	curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
	brew install npm
	brew install soket.io

test :
	@make -C ./lib/libft
	gcc $(SOURCES) -L ./lib/libft/ -lft -o test_corewar -I $(INC_DIR) -I ./lib/libft/inc/

debug_asm : libft
	gcc -ggdb $(ASM_SOURCES) ./lib/libft/libft.a -I ./lib/libft/inc -I ./inc -o asm_debug
	lldb ./asm_debug test.s

debug_cor : libft
	gcc -ggdb $(COR_SOURCES) ./lib/libft/libft.a -I ./lib/libft/inc -I ./inc -o corewar_debug
	#lldb ./corewar_debug ???

.PHONY: all clean fclean re libft corewar asm obj
