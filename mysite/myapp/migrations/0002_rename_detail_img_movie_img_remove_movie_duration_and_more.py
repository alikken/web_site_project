# Generated by Django 4.1.6 on 2023-04-10 16:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='movie',
            old_name='detail_img',
            new_name='img',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='duration',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='premiere',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='production',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='title_img',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='url',
        ),
        migrations.AddField(
            model_name='movie',
            name='description',
            field=models.TextField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='hall',
            name='col_count',
            field=models.PositiveIntegerField(default=20),
        ),
        migrations.AlterField(
            model_name='hall',
            name='row_count',
            field=models.PositiveIntegerField(default=10),
        ),
        migrations.DeleteModel(
            name='Production',
        ),
    ]