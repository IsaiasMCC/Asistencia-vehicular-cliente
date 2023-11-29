// To parse this JSON data, do
//
//     final responseAllPostulacion = responseAllPostulacionFromJson(jsonString);

import 'dart:convert';

ResponseAllPostulacion responseAllPostulacionFromJson(String str) => ResponseAllPostulacion.fromJson(json.decode(str));

String responseAllPostulacionToJson(ResponseAllPostulacion data) => json.encode(data.toJson());

class ResponseAllPostulacion {
    final bool? success;
    final List<Postulacione>? postulaciones;

    ResponseAllPostulacion({
        this.success,
        this.postulaciones,
    });

    factory ResponseAllPostulacion.fromJson(Map<String, dynamic> json) => ResponseAllPostulacion(
        success: json["success"],
        postulaciones: json["postulaciones"] == null ? [] : List<Postulacione>.from(json["postulaciones"]!.map((x) => Postulacione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "postulaciones": postulaciones == null ? [] : List<dynamic>.from(postulaciones!.map((x) => x.toJson())),
    };
}

class Postulacione {
    final int? id;
    final String? estimacionLlegada;
    final String? estimacionCosto;
    final int? estado;
    final int? tallerId;
    final int? tecnicoId;
    final int? solicitudId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Taller? taller;

    Postulacione({
        this.id,
        this.estimacionLlegada,
        this.estimacionCosto,
        this.estado,
        this.tallerId,
        this.tecnicoId,
        this.solicitudId,
        this.createdAt,
        this.updatedAt,
        this.taller,
    });

    factory Postulacione.fromJson(Map<String, dynamic> json) => Postulacione(
        id: json["id"],
        estimacionLlegada: json["estimacion_llegada"],
        estimacionCosto: json["estimacion_costo"],
        estado: json["estado"],
        tallerId: json["taller_id"],
        tecnicoId: json["tecnico_id"],
        solicitudId: json["solicitud_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        taller: json["taller"] == null ? null : Taller.fromJson(json["taller"]),
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
        "taller": taller?.toJson(),
    };
}

class Taller {
    final int? id;
    final String? nombre;
    final String? nit;
    final String? direccion;
    final String? telefono;
    final String? foto;
    final int? userId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Taller({
        this.id,
        this.nombre,
        this.nit,
        this.direccion,
        this.telefono,
        this.foto,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory Taller.fromJson(Map<String, dynamic> json) => Taller(
        id: json["id"],
        nombre: json["nombre"],
        nit: json["nit"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        foto: json["foto"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "nit": nit,
        "direccion": direccion,
        "telefono": telefono,
        "foto": foto,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
