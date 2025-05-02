//
//  FieldModel.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

struct FieldModel {
    var value: String
    var error: String?
    var fieldType: FieldType
    
    init(value: String, error: String? = nil, fieldType: FieldType) {
        self.value = value
        self.error = error
        self.fieldType = fieldType
    }
    
    mutating func validate(confirmPassword: String? = nil) -> Bool {
        error = fieldType.validate(value: value, confirmPassword: confirmPassword)
        return error == nil
    }
    
    mutating func validateOnSubmit(confirmPassword: String? = nil) {
        error = fieldType.validate(value: value, confirmPassword: confirmPassword)
    }
}
