import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenTransitionManagerUser extends StatefulWidget {
  const ScreenTransitionManagerUser({super.key});

  @override
  State<ScreenTransitionManagerUser> createState() => _ScreenTransitionManagerUserState();
}

class _ScreenTransitionManagerUserState extends State<ScreenTransitionManagerUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          context: context,
          pageName: 'Mudar tipo de usuário',
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você é um dono de restaurante?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10,),

            const Text(
              'Se sim, temos uma ótima notícia para te contar! Você pode cadastrar seu restaurante no nosso aplicativo e começar a vender suas pizzas!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20,),

            SectionVisible(
              nameSection: 'Como funciona ?', 
              isShowPart: true,
              child: Column(
                children: [

                  const Text(
                    'É muito simples, basta você clicar no botão abaixo e preencher o formulário com os dados do seu restaurante.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Text(
                    'Após isso, iremos analisar os dados e entraremos em contato com você para finalizar o cadastro.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Text(
                    'Após o cadastro finalizado, você já poderá começar a vender!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Text(
                    'Ah, o melhor de tudo, você NÃO precisa esperar nossa validação para cadastrar seus produtos. Você já pode começar a cadastrar seus deliciosos produtos e mostrar a todos os usuários GRATUITAMENTE!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  SectionVisible(
                    nameSection: 'Funcionalidades', 
                    isShowPart: true,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá cadastrar seus produtos e vender para os clientes que estão próximos ao seu restaurante.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    
                          SizedBox(height: 20,),
                    
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá cadastrar seus funcionários e gerenciar as vendas.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá gerenciar o horário de trabalho de seus funcionários.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá definir em quais aparelhos seus funcionários poderão acessar para realizar pedidos.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    
                          SizedBox(height: 20,),
                    
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá cadastrar promoções para seus produtos.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    
                          SizedBox(height: 20,),
                    
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green,),
                    
                              SizedBox(width: 20,),
                              
                              Flexible(
                                child: Text(
                                  'Você poderá gerenciar o horário de funcionamento do seu restaurante.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),

                  const SizedBox(height: 20,),

                  const Text(
                    'Agora que você já sabe como funciona, clique no botão abaixo e comece a vender seus deliciosos produtos!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),

      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/register_business');
              }, 
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, color: Colors.white,),

                  SizedBox(width: 10,),

                  Text(
                    'Cadastrar restaurante',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}