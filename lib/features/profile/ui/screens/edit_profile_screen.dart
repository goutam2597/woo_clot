import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _country;
  DateTime? _dob;
  String _gender = 'Male';

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _name = TextEditingController(text: profile.name);
    _email = TextEditingController(text: profile.email);
    _phone = TextEditingController(text: profile.phone);
    _country = TextEditingController(text: profile.country);
    _dob = profile.dob;
    _gender = profile.gender;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _AvatarPicker(
              onChange: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Change avatar')));
              },
            ),
            const SizedBox(height: 16),
            _Input(label: 'Full Name', controller: _name),
            const SizedBox(height: 12),
            _Input(
              label: 'Email',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _Input(
              label: 'Phone',
              controller: _phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _DateField(
              label: 'Date of Birth',
              value: _dob,
              onPick: (d) => setState(() => _dob = d),
            ),
            const SizedBox(height: 12),
            _GenderField(
              value: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),
            const SizedBox(height: 12),
            _Input(label: 'Country', controller: _country),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<ProfileProvider>().update(
                    name: _name.text.trim(),
                    email: _email.text.trim(),
                    phone: _phone.text.trim(),
                    dob: _dob,
                    gender: _gender,
                    country: _country.text.trim(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated')),
                  );
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            // Change Password moved to its own screen from Profile.
          ],
        ),
      ),
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  final VoidCallback onChange;
  const _AvatarPicker({required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/dummy/dr.png'),
        ),
        const SizedBox(width: 12),
        TextButton.icon(
          onPressed: onChange,
          icon: const Icon(Icons.photo_camera),
          label: const Text('Change Photo'),
        ),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const _Input({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onPick;
  const _DateField({
    required this.label,
    required this.value,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final text = value == null
        ? 'Select date'
        : '${value!.day.toString().padLeft(2, '0')}/${value!.month.toString().padLeft(2, '0')}/${value!.year}';
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime(now.year - 20, now.month, now.day),
          firstDate: DateTime(1900),
          lastDate: now,
        );
        if (picked != null) onPick(picked);
      },
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(text)),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }
}

class _GenderField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _GenderField({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: const [
        DropdownMenuItem(value: 'Male', child: Text('Male')),
        DropdownMenuItem(value: 'Female', child: Text('Female')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: (v) => onChanged(v ?? value),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
        ),
        labelText: 'Gender',
      ),
    );
  }
}
