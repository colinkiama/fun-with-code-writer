project('optimus-prime', 'vala', 'c',
  version: '0.0.1')

valac = meson.get_compiler('vala')
libvala_version = run_command(valac.cmd_array()[0], '--api-version').stdout().strip()

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  dependency('libvala-@0@'.format(libvala_version))
]

add_project_arguments(['--enable-experimental'], language: 'vala')

subdir('src')
