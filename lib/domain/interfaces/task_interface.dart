// To parse this JSON data, do
//
//     final responsePostulacion = responsePostulacionFromJson(jsonString);

import 'dart:convert';

ResponsePostulacion responsePostulacionFromJson(String str) => ResponsePostulacion.fromJson(json.decode(str));

String responsePostulacionToJson(ResponsePostulacion data) => json.encode(data.toJson());

class ResponsePostulacion {
    final bool? success;
    final Data? data;

    ResponsePostulacion({
        this.success,
        this.data,
    });

    factory ResponsePostulacion.fromJson(Map<String, dynamic> json) => ResponsePostulacion(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    final int? id;
    final String? estimacionLlegada;
    final String? estimacionCosto;
    final int? estado;
    final int? tallerId;
    final int? tecnicoId;
    final int? solicitudId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Solicitud? solicitud;

    Data({
        this.id,
        this.estimacionLlegada,
        this.estimacionCosto,
        this.estado,
        this.tallerId,
        this.tecnicoId,
        this.solicitudId,
        this.createdAt,
        this.updatedAt,
        this.solicitud,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        estimacionLlegada: json["estimacion_llegada"],
        estimacionCosto: json["estimacion_costo"],
        estado: json["estado"],
        tallerId: json["taller_id"],
        tecnicoId: json["tecnico_id"],
        solicitudId: json["solicitud_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        solicitud: json["solicitud"] == null ? null : Solicitud.fromJson(json["solicitud"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estimacion_llegada": estimacionLlegada,
        "estimacion_costo": estimacionCosto,
        "estado": estado,
        "taller_id": tallerId,
        "tecnico_id": tecnicoId,
        "solicitud_id": solicitudId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "solicitud": solicitud?.toJson(),
    };
}

class Solicitud {
    final int? id;
    final DateTime? fecha;
    final String? hora;
    final String? notaAudio;
    final String? latitud;
    final String? longitud;
    final int? estado;
    final int? userId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;

    Solicitud({
        this.id,
        this.fecha,
        this.hora,
        this.notaAudio,
        this.latitud,
        this.longitud,
        this.estado,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        id: json["id"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        hora: json["hora"],
        notaAudio: json["nota_audio"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        estado: json["estado"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "nota_audio": notaAudio,
        "latitud": latitud,
        "longitud": longitud,
        "estado": estado,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
    final int? id;
    final String? nombre;
    final String? apellido;
    final String? ci;
    final String? direccion;
    final String? telefono;
    final dynamic avatar;
    final String? email;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    User({
        this.id,
        this.nombre,
        this.apellido,
        this.ci,
        this.direccion,
        this.telefono,
        this.avatar,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        ci: json["ci"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        avatar: json["avatar"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "ci": ci,
        "direccion": direccion,
        "telefono": telefono,
        "avatar": avatar,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
