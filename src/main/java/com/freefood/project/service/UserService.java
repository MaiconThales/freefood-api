package com.freefood.project.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.freefood.project.dto.UserDTO;
import com.freefood.project.model.User;
import com.freefood.project.payload.response.MessageResponse;

public interface UserService {
	
	/**
	 * Retorna o User pelo ID passado.
	 * 
	 * @param id do User
	 * @return Retorna o menu de acordo com o ID passado no parametro.
	 * */
	ResponseEntity<UserDTO> findById(Long idUser);
	
	
	/**
	 * Função para fazer o update do objeto.
	 * 
	 * @param user é o objeto que se deseja fazer o update
	 * @return Com a ação bem sucedida o spring vai retornar o objeto que sofreu o update
	 * */
	ResponseEntity<MessageResponse> updateUser(User user);
	
	User save(User user);
	
	String getLanguageUser(Long idUser);
	
	User findByUsername(String username);

	ResponseEntity<MessageResponse> saveImageUser(MultipartFile file, UserDTO user);
	
}
