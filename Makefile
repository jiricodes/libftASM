# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jnovotny <jnovotny@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/30 21:29:07 by jnovotny          #+#    #+#              #
#    Updated: 2022/07/01 10:06:04 by jnovotny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TARGET=libfts.a

ASM_CC=nasm
ASM_FLAGS=
ASM_PREFIX=

ASM_SRC=ft_bzero.s

ASM_SRC_DIR = src
ASM_TMP = tmp

OBJS = $(patsubst %.s, $(ASM_TMP)/%.o, $(ASM_SRC))

UNAME := $(shell uname -s)

ifeq ($(UNAME), Linux)
	ASM_FLAGS += -felf64
	ASM_PREFIX = -dLINUX=1
else
	ASM_FLAGS += -fmacho64
	ASM_PREFIX = --prefix _ -dOSX=1
endif

.PHONY: all clean fclean re

all: $(TARGET)

$(TARGET): $(ASM_TMP) $(OBJS)
	ar rcs $(TARGET) $(OBJS)

$(ASM_TMP)/%.o: $(addprefix $(ASM_SRC_DIR)/,%.s)
	$(ASM_CC) $(ASM_FLAGS) -o $@ $(ASM_PREFIX) $^

$(ASM_TMP):
	mkdir -p $(ASM_TMP)

prereqs:
	sudo apt-get -y install nasm

clean:
	rm -r $(ASM_TMP)

fclean: clean
	rm -f $(TARGET)

re: fclean all