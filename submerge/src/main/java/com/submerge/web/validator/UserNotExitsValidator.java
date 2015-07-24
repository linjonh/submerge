package com.submerge.web.validator;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.submerge.service.UserService;

@Component("userNotExitsValidator")
@Scope(value = "request")
public class UserNotExitsValidator implements Validator {

	private static final String USER_EXISTS = "User already exists";

	@Autowired
	private UserService userService;

	@Override
	public void validate(FacesContext context, UIComponent component, Object value) throws ValidatorException {
		String email = (String) value;
		if (this.userService.findByName(email) != null) {
			throw new ValidatorException(new FacesMessage(FacesMessage.SEVERITY_ERROR, USER_EXISTS, null));
		}
	}

}
