package com.freefood.project.service.impl;

import java.io.IOException;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.freefood.project.dto.UserDTO;
import com.freefood.project.model.User;
import com.freefood.project.payload.response.MessageResponse;
import com.freefood.project.repository.UserRepository;
import com.freefood.project.service.UserService;
import com.freefood.project.service.UtilsService;

@Service(value = "userService")
public class UserServiceImpl implements UserService {
	
	private static final String SERVER_ERROR = "GLOBAL_WORD.WORD_MSG_SERVER_ERROR";
	
	private final UserRepository userRepository;
	private final UtilsService utils;
	private final PasswordEncoder encoder;
	private final ModelMapper modelMapper;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository, UtilsService utils, PasswordEncoder encoder, ModelMapper modelMapper) {
		this.userRepository = userRepository;
		this.utils = utils;
		this.encoder = encoder;
		this.modelMapper = modelMapper;
	}

	@Override
	public ResponseEntity<UserDTO> findById(Long idUser) {
		UserDTO resultDto = null;
		try {
			Optional<User> result = this.userRepository.findById(idUser);
			if(result.isPresent()) {
				result.get().setPassword("");
				resultDto = modelMapper.map(result.get(), UserDTO.class);
			}

			if (resultDto != null) {
				return new ResponseEntity<>(resultDto, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<>(resultDto, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<MessageResponse> updateUser(User user) {
		try {
			if (this.utils.verifyUserLogged(user.getUsername())) {
				if (!user.getPassword().isBlank()) {
					user.setPassword(encoder.encode(user.getPassword()));
				} else {
					String password = this.userRepository.getPasswordByUserId(user.getId());
					user.setPassword(password);
				}
				this.userRepository.save(user);
				return new ResponseEntity<>(new MessageResponse("GLOBAL_WORD.WORD_MSG_SUCCESS"), HttpStatus.OK);
			}
			return new ResponseEntity<>(new MessageResponse("GLOBAL_WORD.WORD_MSG_FORBIDDEN"), HttpStatus.FORBIDDEN);
		} catch (Exception e) {
			return new ResponseEntity<>(new MessageResponse(SERVER_ERROR), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public User save(User user) {
		return this.userRepository.save(user);
	}

	@Override
	public String getLanguageUser(Long idUser) {
		return this.userRepository.getLanguageUser(idUser);
	}

	@Override
	public User findByUsername(String username) {
		Optional<User> result = this.userRepository.findByUsername(username);
		if(result.isPresent()) {
			return result.get();
		}
		return null;
	}

	@Override
	public ResponseEntity<MessageResponse> saveImageUser(MultipartFile file, UserDTO user) {
		User result = modelMapper.map(user, User.class);
		try {
			result.setPicByte(file.getBytes());
		} catch (IOException e) {
			return new ResponseEntity<>(new MessageResponse(SERVER_ERROR), HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return this.updateUser(result);
	}
	
}
