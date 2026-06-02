import 'package:app_mobile/controller/course_service.dart';
import 'package:app_mobile/controller/login_service.dart';
import 'package:app_mobile/view/theme/app_theme.dart';
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final LoginService _loginService = LoginService();
  LoginResult? _credentials;
  bool _loading = true;

  bool get _isAdmin => _credentials?.username?.toLowerCase() == 'admin';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final credentials = await _loginService.getStoredCredentials();

    if (!mounted) return;

    setState(() {
      _credentials = credentials;
      _loading = false;
    });
  }

  void _openCreateCourseModal() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.large),
        ),
      ),
      builder: (context) => const _CreateCourseModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Usuario',
      bottomNavigationBar: const navbar(currentIndex: 2),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final username = _credentials?.username;

    if (username == null) {
      return Center(
        child: AppButton(
          label: 'Voltar para login',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
        ),
      );
    }

    return ListView(
      children: [
        BasicCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      username.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  AppSpacing.horizontalGap(context, 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username, style: AppTypography.title(context)),
                        AppSpacing.verticalGap(context, 4),
                        Text(
                          _isAdmin ? 'Administrador' : 'Usuario comum',
                          style: AppTypography.body(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalGap(context, 20),
              _InfoRow(label: 'Username', value: username),
              AppSpacing.verticalGap(context, 12),
              _InfoRow(
                label: 'Credenciais',
                value: _credentials?.password == null ? 'Nao salvas' : 'Salvas',
              ),
            ],
          ),
        ),
        if (_isAdmin) ...[
          AppSpacing.verticalGap(context, 20),
          AppButton(
            label: 'Cadastrar curso',
            onPressed: _openCreateCourseModal,
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: AppTypography.label(context)),
        ),
        Text(value, style: AppTypography.body(context)),
      ],
    );
  }
}

class _CreateCourseModal extends StatefulWidget {
  const _CreateCourseModal();

  @override
  State<_CreateCourseModal> createState() => _CreateCourseModalState();
}

class _CreateCourseModalState extends State<_CreateCourseModal> {
  final CourseService _courseService = CourseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dayOfWeekController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _professorController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dayOfWeekController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final dayOfWeek = _dayOfWeekController.text.trim();
    final time = _timeController.text.trim();
    final description = _descriptionController.text.trim();
    final location = _locationController.text.trim();
    final professor = _professorController.text.trim();

    if (name.isEmpty ||
        dayOfWeek.isEmpty ||
        time.isEmpty ||
        location.isEmpty ||
        professor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos obrigatorios')),
      );
      return;
    }

    setState(() {
      _submitting = true;
    });

    final result = await _courseService.createCourse(
      name: name,
      dayOfWeek: dayOfWeek,
      time: time,
      description: description,
      location: location,
      professor: professor,
    );

    if (!mounted) return;

    setState(() {
      _submitting = false;
    });

    if (result.success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Curso cadastrado com sucesso')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.errorMessage ?? 'Erro ao cadastrar curso')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.scaleWidth(context, 16),
          right: AppSpacing.scaleWidth(context, 16),
          top: AppSpacing.scaleHeight(context, 18),
          bottom: MediaQuery.of(context).viewInsets.bottom +
              AppSpacing.scaleHeight(context, 16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cadastrar curso', style: AppTypography.title(context)),
              AppSpacing.verticalGap(context, 16),
              AppTextField(
                controller: _nameController,
                label: 'Nome',
              ),
              AppSpacing.verticalGap(context, 12),
              AppTextField(
                controller: _dayOfWeekController,
                label: 'Dia da semana',
                hintText: 'Monday',
              ),
              AppSpacing.verticalGap(context, 12),
              AppTextField(
                controller: _timeController,
                label: 'Horario',
                hintText: '18:30',
              ),
              AppSpacing.verticalGap(context, 12),
              AppTextField(
                controller: _descriptionController,
                label: 'Descricao',
              ),
              AppSpacing.verticalGap(context, 12),
              AppTextField(
                controller: _locationController,
                label: 'Local',
              ),
              AppSpacing.verticalGap(context, 12),
              AppTextField(
                controller: _professorController,
                label: 'Professor',
              ),
              AppSpacing.verticalGap(context, 20),
              AppButton(
                label: _submitting ? 'Cadastrando...' : 'Cadastrar',
                onPressed: _submitting ? () {} : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
