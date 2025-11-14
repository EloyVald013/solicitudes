from django import forms
from .models import ArchivoAdjunto, RespuestaCampo, SeguimientoSolicitud, TipoSolicitud, FormularioSolicitud, CampoFormulario, TIPO_CAMPO, Solicitud

class FormTipoSolicitud(forms.ModelForm):
    class Meta:
        model = TipoSolicitud
        fields = '__all__'
        
class FormFormularioSolicitud(forms.ModelForm):
    class Meta:
        model = FormularioSolicitud
        fields = ['tipo_solicitud', 'nombre', 'descripcion']
        labels = {
            'tipo_solicitud': 'Tipo de Solicitud Asociada',
            'nombre': 'Título del Formulario',
            'descripcion': 'Instrucciones o Descripción'
        }
        
class FormCampoFormulario(forms.ModelForm):
    tipo = forms.ChoiceField(
        choices=TIPO_CAMPO,
        widget=forms.Select 
    )

    class Meta:
        model = CampoFormulario
        fields = '__all__'
        
        labels = {
            'formulario': 'Formulario de Solicitud',
            'nombre': 'Nombre',
            'etiqueta': 'Etiqueta para el Usuario',
            'tipo': 'Tipo de Campo',
            'requerido': '¿Es obligatorio?',
            'opciones': 'Opciones del campo',
            'cantidad_archivos': 'Archivos Permitidos'
        }
        
class FormSolicitud(forms.ModelForm):
    class Meta:
        model = Solicitud
        exclude = ['usuario', 'folio', 'fecha_creacion']
        
class FormRespuestaCampo(forms.ModelForm):
    class Meta:
        model = RespuestaCampo
        fields = ['valor']
        
class FormSeguimientoSolicitud(forms.ModelForm):
    class Meta:
        model = SeguimientoSolicitud
        fields = ['observaciones', 'estatus'] 

class FormArchivoAdjunto(forms.ModelForm):
    class Meta:
        model = ArchivoAdjunto
        exclude = ['respuesta', 'solicitud']
        fields = ['archivo', 'nombre']