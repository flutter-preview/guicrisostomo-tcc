import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';

class ScreenTerms extends StatelessWidget {
  const ScreenTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Termos de uso',
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Seção 1 - O que fazemos com suas informações?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quando você realiza algum pedido em nosso aplicativo, como parte do processo de compra e venda, coletamos as informações pessoais que você nos fornece, tais como nome, e-mail e endereço.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Quando você acessa nosso aplicativo, também recebemos automaticamente o protocolo de internet do seu computador, endereço de IP, endereço de protocolo da Internet (IP) do seu computador, provedor de serviços de internet e informações de rastreamento de páginas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Com base nas informações que coletamos, podemos:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Fornecer e melhorar o serviço. Usamos as informações que você nos fornece para fornecer o serviço que você solicitou e para melhorar nossos serviços.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Comunicar-se com você. Podemos usar suas informações de contato para lhe enviar informações sobre nossos serviços e sobre alterações nos termos, condições, e políticas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Fornecer suporte ao cliente. Se você entrar em contato conosco por e-mail, podemos usar o histórico de sua conversa para ajudar a responder a suas perguntas de suporte mais rapidamente.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Fornecer análises ou informações valiosas para nós ou para outros. Podemos usar as informações que coletamos para avaliar o uso que você faz do nosso serviço e para compilar estatísticas sobre a forma como nossos usuários interagem com nosso aplicativo, para que possamos melhorar nossos serviços.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Monitorar os padrões de uso. Podemos usar as informações que coletamos para monitorar os padrões de uso e os níveis de atividade em nosso aplicativo.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '• Detectar, evitar e lidar com fraudes. Podemos usar as informações que coletamos para detectar, evitar e lidar com fraudes, problemas técnicos ou questões de segurança.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 2 - Consentimento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Como vocês obtêm meu consentimento?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Quando você fornece informações pessoais para completar uma transação, verificar seu cartão de crédito, fazer um pedido, providenciar uma entrega ou retornar uma compra, entendemos que você está concordando com a coleta de dados e com o uso dessas informações para esse fim específico apenas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Se pedirmos suas informações pessoais por uma razão secundária, como marketing, vamos lhe pedir diretamente por seu consentimento, ou lhe fornecer a oportunidade de dizer não.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'E se eu quiser retirar meu consentimento?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Se após você nos fornecer seus dados, você mudar de ideia, você pode nos avisar enviando um e-mail para  [email protected] e nós removeremos seus dados do nosso banco de dados.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 3 - Divulgação',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Podemos divulgar suas informações pessoais se formos obrigados pela lei a fazê-lo ou se você violar nossos Termos de Serviço.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 4 - Serviços de terceiros',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No geral, os fornecedores terceirizados usados por nós irão apenas coletar, usar e divulgar suas informações na medida do necessário para permitir que eles realizem os serviços que eles nos fornecem.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No entanto, certos fornecedores de serviços terceirizados, tais como gateways de pagamento e outros processadores de transações de pagamento, têm suas próprias políticas de privacidade em relação à informação que somos obrigados a fornecer para eles de suas transações relacionadas com compras.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Para esses fornecedores, recomendamos que você leia suas políticas de privacidade para que você possa entender a maneira na qual suas informações pessoais serão usadas por esses fornecedores.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Em particular, lembre-se que certos fornecedores podem estar localizados ou possuir instalações que são localizadas em uma jurisdição diferente da sua ou da nossa. Assim, se você quiser continuar com uma transação que envolve os serviços de um fornecedor de serviço terceirizado, então suas informações podem tornar-se sujeitas às leis da(s) jurisdição(ões) nas quais esse fornecedor de serviço ou suas instalações estão localizados.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Uma vez que você deixe o aplicativo ou seja redirecionado para o aplicativo de um terceiro, você não será mais regido por esta Política de Privacidade ou pelos Termos de Serviço do nosso aplicativo.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Links',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Quando você clica em links na nossa loja, eles podem lhe direcionar para fora do nosso aplicativo. Não somos responsáveis pelas práticas de privacidade de outros sites e lhe encorajamos a ler as declarações de privacidade deles.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 5 - Segurança',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Para proteger suas informações pessoais, tomamos precauções razoáveis e seguimos as melhores práticas da indústria para nos certificar que elas não serão perdidas inadequadamente, usurpadas, acessadas, divulgadas, alteradas ou destruídas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Se você nos fornecer as informações de cartão de crédito, essas informações são criptografadas usando tecnologia "secure socket layer" (SSL) e armazenadas com uma criptografia AES-256. Embora nenhum método de transmissão pela Internet ou armazenamento eletrônico é 100% seguro, seguimos todos os requisitos da PCI-DSS e implementamos padrões adicionais geralmente aceitos pela indústria.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 6 - Idade de consentimento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Ao usar este site, você declara que você tem pelo menos a idade de maioridade em seu estado ou província de residência e que você nos deu seu consentimento para permitir que qualquer um dos seus dependentes menores usem este site.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seção 7 - Alterações nesta política de privacidade',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Reservamos o direito de modificar esta política de privacidade a qualquer momento, então, por favor, revise-a com frequência. Alterações e esclarecimentos vão surtir efeito imediatamente após sua publicação no aplicativo. Se fizermos alterações de materiais para esta política, iremos notificá-lo aqui que eles foram atualizados, para que você tenha ciência sobre quais informações coletamos, como as usamos, e sob que circunstâncias, se alguma, usamos e/ou divulgamos elas.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Se você nos fornecer informações pessoais, você nos dá a autorização para usar essas informações de acordo com esta política.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Contate-nos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: const [
                Icon(Icons.email),
                SizedBox(width: 10),
                Text(
                  'guilherme.silva99872@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: const [
                Icon(Icons.phone),
                SizedBox(width: 10),
                Text(
                  '(11) 9 9999-9999',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: const [
                Icon(Icons.location_city),
                SizedBox(width: 10),
                Text(
                  'São Paulo - SP',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    'https://www.google.com';
                  },
                  child: const Text(
                    'https://www.google.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Última atualização: 2021-05-01',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}