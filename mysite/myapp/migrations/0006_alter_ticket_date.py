# Generated by Django 4.1.6 on 2023-04-11 20:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0005_alter_ticket_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ticket',
            name='date',
            field=models.DateTimeField(),
        ),
    ]
