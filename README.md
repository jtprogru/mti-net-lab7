# mti-net-lab7

Примерный код Terraform, который использовался для решения лабораторной работы 7 по предмету Компьютерные сети МТИ

## Процесс настройки

1. Установить Yandex.Cloud CLI - [официальная документация](https://cloud.yandex.ru/docs/cli/quickstart) и выполнить инициализацию согласно документации.
2. Указать все свои переменные в файле `secrets.tfvars`;
3. Активировать профиль со своим облаком `make init`;
4. Посмотреть план terraform'a: `make plan`;
5. Применить изменения инфраструктуры: `make apply`;

### Пример переменных

Примерно таким образом должен выглядеть файл с переменными `secrets.tfvars`:

```hcl
service_account_auth_key = {
   "id": "xxxxxx",
   "service_account_id": "yyyyy",
   "created_at": "2022-03-12T18:56:30.434571587Z",
   "key_algorithm": "RSA_2048",
   "public_key": "-----BEGIN PUBLIC KEY-----\nHwAQAB\n-----END PUBLIC KEY-----\n",
   "private_key": "-----BEGIN PRIVATE KEY-----\n35w==\n-----END PRIVATE KEY-----\n"
}

cloudflare_api_token = "-qwerty"
access_key = "qazwsx"
secret_key = "qazwsxedc"
kms_key_id = "lpkoji"
```

В файле `cloud-init/ci.yaml` указать свои данные согласно примеру:

```yaml
#cloud-config
users:
  - name: jtprogru
    gecos: Michael Savin
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    lock_passwd: true
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHP9Xd+Xdd2WQA/IZFe1wvhYPqXANrO3bhg6/3emC9TC jtprogru@gmail.com
```

## Установка VPN

Выполнить в консоли и ответить на задаваемые вопросы:

```shell
curl -L https://install.pivpn.io | bash
```

## License

[LICENSE](LICENSE)
