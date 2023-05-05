import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class OfferForTheSeller extends StatefulWidget {
  const OfferForTheSeller({Key? key}) : super(key: key);

  @override
  _OfferForTheSeller createState() => _OfferForTheSeller();
}

const htmlData = r"""
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">В</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">се споры, возникающие между Администратором и Пользователем, разрешаются в претензионном порядке.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Срок ответа на пр</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">етензию &mdash; 30&nbsp; рабочих д</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">ней с момента ее получения адресатом.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">При невозможности прийти к соглашению спор может быть передан на разрешение суда в Арбитражный Суд Чеченской Республики, если законом не предусмотрена подсудность по выбору истца.</span></li>
</ol>
<li aria-level="1">
<h2 style="line-height: 1.38; margin-right: 22.033464566929155pt; text-align: justify; margin-top: 16pt; margin-bottom: 6pt;"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Способы обмена документами</span></h2>
</li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Стороны признают надлежащим подписание отчетов, и других документов путем обмена отсканированными копиями по электронной почте.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Такие документы считаются подписанными простой электронной подписью и приравниваются к документам на бумажном носителе.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Стороны признают надлежащим обмен информацией с помощью следующих средств коммуникации:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">адреса электронной почты;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Профиль.</span></li>
</ol>
<h1 style="line-height: 1.3800000000000001; margin-top: 0pt; margin-bottom: 10pt;"><span style="font-size: 16pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Оферта для продавцов Маркетплейса &laquo;LUNA market&raquo;&nbsp;</span></h1>
<p style="line-height: 1.3800000000000001; margin-top: 0pt; margin-bottom: 10pt;"><span style="font-size: 9pt; font-family: Roboto,sans-serif; color: #999999; background-color: #fff2cc; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Редакция №__ от &ldquo;__&rdquo;_____ 20__г.</span></p>
<p style="line-height: 1.3800000000000001; margin-top: 0pt; margin-bottom: 10pt;">&nbsp;</p>
<table style="border: none; border-collapse: collapse;">
<tbody>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">владелец Маркетплейса, Хаджиев Мовсади Ахмедович</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Оферта</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">данный документ, предложение Администратора заключить Договор на изложенных в ней условиях</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Договор</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">договор между Администратором и Продавцом</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Адреса электронных почт сторон для обмена информацией и документами:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавца &mdash; адрес электронной почты, указанный в Профиле;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратора &mdash; адрес электронной почты, указанный в Оферте.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец обязан сохранять конфиденциальность реквизитов доступа к Профилю, мессенджерам, логина и пароля от электронной почты.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец принимает на себя всю ответственность за действия своих сотрудников, имеющих доступ к согласованным средствам коммуникации.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Обмен информацией и документами с помощью согласованных средств коммуникации имеет юридическую силу, в том числе в сл</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">учае судебного ра</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">збирательства.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор направляет на адрес электронной почты, номер мобильного телефона, предоставленны</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">е Продавцом, в Профиле, в мессенджерах сообщения, уведомления, запросы, сведения информационного характера, связанные с Сервисом, Товарами.</span></li>
</ol>
<li aria-level="1">
<h2 style="line-height: 1.38; margin-right: 22.033464566929155pt; text-align: justify; margin-top: 16pt; margin-bottom: 6pt;"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Заключительные положения</span></h2>
</li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Пользователь &mdash; юридическое лицо или индивидуальный предприниматель &mdash; который предлагает Товары к продаже на Маркетплейсе</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Соглашение</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">документ, определяющий условия использования мобильного приложения </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">&laquo;LUNA market&raquo; и порядок регистрации пользователей</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Тариф</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">порядок определения размера агентского вознаграждения Администратора</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Заказ&nbsp;</span></p>
</td>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Договор действует с момент акцепта до момента его расторжения.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец вправе в одностороннем порядке отказаться от исполнения Договора, уведомив Администратора за&nbsp; 30 календарных дней до предполагаемой даты расторжения.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Если Продавец нарушил условия Договора или иных правовых документов, размещенных в Сервисе, Администратор вправе в одностороннем порядке отказаться от Договора, удалив Профиль Продавца. Администратор удаляет Профиль в порядке, предусмотренном в Соглашении.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Стороны с момента расторжения Договора:&nbsp;</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">обеспечивают исполнение всех размещенных, но незавершенных Заказов;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">продолжают коммуникации между собой или с Покупателями в отношении незавершенных Заказов. При этом Продавец самостоятельно принимает отказы и возвраты Покупателем Товара.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">При досрочном расторжении Договора стороны производят взаиморасчеты на основании отчета. Администратор удаляет Профиль и Карточки Товаров Продавца.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Вопросы, не урегулированные Договором, подлежат разрешению в соответствии с законодательством РФ.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Если какое-либо из положений Договора окажется ничтожным в </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">соответствии</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;"> с законодательством РФ, остальные положения остан</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">утся в силе, а Договор будет исполняться Сторонами без учета такого положения.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор вправе в любое время в одностороннем порядке вносить изменения в условия Оферты, уведомив Продавца в Профиле или посредством электронной почты.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец принимает (акцептует) новые условия Оферты, продолжая использовать Маркетплейс на изложенных в ней условиях.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Изменения вступают в силу с момента опубликования новой версии Оферты в Маркетплейсе.</span></li>
</ol>
</ol>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">запрос Покупателя на приобретение и доставку Товара,&nbsp; направленный с помощью Маркетплейса</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Карточка Товара</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">предложение Продавца, содержащее основные сведения о предлагаемом к продаже Товаре</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Профиль</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">учетная запись Пользователя на Маркетплейсе, в которой доступен определенный функционал</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Регистрация</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">установленный порядок действий, после выполнения которых Пользователь получает доступ к Профилю</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Маркетплейс</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">мобильное приложение &laquo;LUNA market&raquo;, предназначенное для покупки, продажи и доставки Товаров&nbsp;</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Товар</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; background-color: #ffffff; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">вещи, представленные Продавцом к продаже на Маркетплейсе</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Банк</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; background-color: #ffffff; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #00ffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">банк &laquo;_______&raquo;</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">, с которым Администратор заключил договор о подключении эквайринга и сплитовании (разделении) платежей</span></p>
</td>
</tr>
<tr style="height: 13.5pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Доставщик</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; background-color: #ffffff; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">курьерской службой, с которой Администратор заключил договор</span></p>
</td>
</tr>
</tbody>
</table>
<p style="line-height: 1.38; margin-top: 10pt; margin-bottom: 5pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Иные термины, использованные в Оферте, применяются в значении, определенном Пользовательским соглашением.</span></p>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="1"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Предмет</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор по поручению Продавца от его имени и за его счет организует прием платежей по Заказам.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">За выполнение поручения Продавец выплачивает Администратору агентское вознаграждение согласно Тарифам.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор предоставляет Продавцу дополнительные функциональные возможности Маркетплейса в целях продажи Товаров.</span></li>
</ol>
<li aria-level="1">
<h2 style="line-height: 1.38; margin-top: 16pt; margin-bottom: 6pt;"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Дополнительные функциональные возможности</span></h2>
</li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавцу доступны следующие функциональные возможности Маркетплейса:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">размещать на Маркетплейсе Карточки Товара;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">получать уведомления о Заказах;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">получать документы от Администратора при реализации Товара по договору купли-продажи Товара, возврате Товара Покупателем;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">иные возможности, доступные в его Профиле;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">перечислять вознаграждение Блогерам согласно типовому договору на оказание рекламных услуг.</span></li>
</ol>
</ol>
<li aria-level="1"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Получение статуса Продавца</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Любой Пользователь может получить статус Продавца, направив заявку на сотрудничество.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Для направления заявки Пользователь:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">заполняет все обязательные поля заявки на сотрудничество;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">подтверждает направление путем ввода смс-кода.&nbsp;</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Направление заявки на сотрудничество означает принятие (акцепт) Оферты и Соглашения.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">С этого момента принятия (акцепта) Оферты Договор считается заключенным, а Пользователь получает статус Продавца и доступ к Профилю с дополнительными функциональными возможностями.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Последующий доступ Продавца к Профилю осуществляется при указании логина и пароля.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">вправе проверить полученные от Продавца сведения и/или запросить дополнительные сведения, в том числе сканы ОГРН/ИП, И</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">НН, Устав и др.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец обязан предоставить такие сведения в течение 1 рабочего дня с момента получения запроса Администратора.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор вправе отказать Продавцу в сотрудничестве без объяснения причин. Отказ от сотрудничества означает односторонний отказ Администратора от Договора и удаление всех данных и Контента Продавца.</span></li>
</ol>
<li aria-level="1">
<h2 style="line-height: 1.38; margin-right: 22.033464566929155pt; text-align: justify; margin-top: 16pt; margin-bottom: 6pt;"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Порядок зачисления платежей по Заказам</span></h2>
</li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Пользователи оплачивают Заказы через эквайринг Банка, подключенный Администратором к Маркетплейсу.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Банк разделяет (сплитует) платежи по Заказам и не позднее следующего рабочего дня после оплаты направляет платежи получателям.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец получает платежи по Заказам за вычетом денежных средств, причитающихся другим получателям:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">комиссии Банка на зачисление платежа;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">агентского вознаграждения Администратора;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">вознаграждения Блогера, если Заказ совершен в рамках маркетинговой акции;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">возвратов денежных средств Пользователям по отмененным Заказам;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">штрафов и неустоек в пользу Администратора, предусмотренных Договором.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор не принимает платежи по Заказам на свой счет.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Сроки совершения банковских операций установлены правилами Банка, с которыми Продавец может ознакомиться по адресу _______. При нарушении условий совершения банковских операция Продавец может направить обращение Администратору.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор считается исполнившим свои обязательства перед Продавцом по зачислению платежей по Заказам в момент зачисления денежных средств на корреспондентский счет банка Продавца.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор направляет Продавцу отчет о совершенных Заказах, размере агентского вознаграждения и начисленных штрафах и неустойках.</span></li>
</ol>
<li aria-level="1">
<h2 style="line-height: 1.38; margin-right: 22.033464566929155pt; text-align: justify; margin-top: 16pt; margin-bottom: 6pt;"><span style="font-size: 12pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Вознаграждение Администратора</span></h2>
</li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Агентское вознаграждение Администратора рассчитывается от суммы оплат, полученных от Покупателей за Товары Продавца по всем Заказам в отчетном периоде.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Размер вознаграждения Администратора зависит от категории Товаров:</span></li>
</ol>
</ol>
<table style="border: none; border-collapse: collapse;">
<tbody>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5pt 5pt 5pt 5pt; overflow: hidden; overflow-wrap: break-word; border: solid #d9d9d9 1pt;">
""";

class _OfferForTheSeller extends State<OfferForTheSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Оферта для продавцов',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Html(
          data: htmlData,
        ),
      ),
    );
  }
}
