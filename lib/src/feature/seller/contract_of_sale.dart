import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ContractOfSale extends StatefulWidget {
  const ContractOfSale({Key? key}) : super(key: key);

  @override
  _ContractOfSale createState() => _ContractOfSale();
}

const htmlData = r"""
<p style="line-height: 1.3800000000000001; margin-top: 0pt; margin-bottom: 10pt;"><span style="font-size: 16pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 500; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Типовой договор купли-продажи &laquo;LUNA market&raquo;&nbsp;</span></p>
<p style="line-height: 1.3800000000000001; margin-top: 0pt; margin-bottom: 10pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #999999; background-color: #fff2cc; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Редакция №__ от &ldquo;__&rdquo;_____ 20__г.</span></p>
<p style="line-height: 1.38; margin-top: 0pt; margin-bottom: 10pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Совершая сделку с помощью Маркетплейса, стороны соглашаются с тем, что к их отношениям применяются условия типового договора купли-продажи </span><em><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">(далее - Договор)</span></em><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">.</span></p>
<p>&nbsp;</p>
<p style="line-height: 1.38; margin-top: 0pt; margin-bottom: 10pt;"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Термины, используемые в документе</span></strong></p>
<table style="border: none; border-collapse: collapse;">
<tbody>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Пользователь &mdash; физическое лицо &mdash; который совершил Заказ</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Пользователь &mdash; юридическое лицо или индивидуальный предприниматель &mdash; который предлагает Товары к продаже на Маркетплейсе</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Заказ&nbsp;</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">запрос Покупателя на приобретение и доставку товара</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Предварительный Заказ</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Заказ товара, который Продавец приобретает специально для Покупателя</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Доставщик</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">лицо, оказывающее Покупателю услугу доставки товара</span></p>
</td>
</tr>
<tr style="height: 0pt;">
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Карточка товара</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">предложение Продавца, содержащее основные сведения о предлагаемом к продаже товаре</span></p>
</td>
</tr>
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
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Маркетплейс</span></p>
</td>
<td style="vertical-align: top; padding: 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt 5.669291338582678pt; overflow: hidden; overflow-wrap: break-word;">
<p style="line-height: 1.38; margin-top: 4pt; margin-bottom: 4pt;"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">мобильное приложение &laquo;LUNA market&raquo;, предназначенное для покупки, продажи и доставки товаров&nbsp;</span></p>
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
</tbody>
</table>
<p>&nbsp;</p>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Предмет</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец обязуется передать в собственность Покупателя </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">товар, а Покупатель обязуется принять и оплатить его.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Договор считается заключенным с момента оплаты Покупателем Заказа.</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Заказ</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">При оформлении Заказа, Покупатель определяет ассортимент, количество и условия доставки товара.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Отправленному Заказу присваивается индивидуальный номер для отслеживания в Сервисе.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Оплачивая Заказ, Покупатель подтверждает, что ознакомлен со сведениями:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">об основных&nbsp; потребительских свойствах товара,</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">о месте изготовления товара,</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">о доставке и порядке возврата товара,</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Если Пользователь до получения отказывается от приобретения товара по Предварительному заказу, он обязан возместить Продавцу расходы, понесенные им на приобретение такого товара.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец вправе удержать соответствующие расходы из суммы денежных средств, уплаченных покупателем в счет Предварительного заказа.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Товар, который был приобретен по Предварительному заказу Покупателя, обмену и возврату не подлежит, при условии, что товар отвечает требованиям качества, соответствует выбранному образу товара и не имеет дефектов.</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Оплата Заказа</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Стоимость Заказа складывается из цены входящих в него товаров и стоимости доставки.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">вправе по своему усмотрению у</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">станавливать или отменять:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">скидки на товар;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">скидочные промо-коды.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель оплачивает Заказ в безналичном порядке способами, доступными на Маркетплейсе.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Обязанность Покупателя по оплате считается выполненной с момента списания денежных средств с его счета.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Чек о покупке направляется Покупателю </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #00ffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">по электронной почте или в Профиль</span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">.</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Отслеживание Заказа</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">С момента оплаты Заказу присваивается индивидуальный номер отслеживания.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель может получить информацию о статусе Заказа в Профиле, а также уточнить ее в чате с Продавцом.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Статус Заказа определяет Администратор на основе данных от Продавца и Доставщика.&nbsp;</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Доставка товара</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель вправе выбрать один из следующих способов доставки:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">курьерская доставка по адресу Покупателя;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">самовывоз из доступных пунктов выдачи заказов.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">При вводе адреса доставки Покупатель гарантирует его достоверность. Покупатель самостоятельно несет риск доставки товара по неверному адресу.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">В момент выбора Покупателем способа доставки определяется Доставщик, стоимость и срок Доставки. Оплачивая Заказ, Покупатель принимает условия доставки.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец не отвечает за сроки доставки товара и не несет ответственность за сохранность Товара после передачи его для доставки, если не является Доставщиком.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Территория доставки Заказа ограничена пределами таможенного союза ЕАЭС.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель получает сведения о статусе доставки Заказа по электронной почте или в Профиле.</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Возврат товара</span></strong></li>
</ul>
<p style="line-height: 1.38; margin-left: 35.43307086614173pt; margin-top: 4pt; margin-bottom: 4pt;"><em><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Общие условия</span></em></p>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">К отношениям о возврате товара применяется закон о защите прав потребителей РФ.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец возвращает Покупателю денежные средства, уплаченные за товар, не позднее 30 дней с момента передачи товара Доставщику на возврат.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Денежные средства за возвращенный товар зачисляются на банковскую карту, которой был оплачен Заказ, если Покупатель не сообщил данные иной банковской карты.</span></li>
</ol>
<p style="line-height: 1.38; margin-left: 35.43307086614173pt; margin-top: 4pt; margin-bottom: 4pt;"><em><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Возврат и отказ от товара надлежащего качества</span></em></p>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель вправе отказаться от товара надлежащего качества в следующие сроки:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">в любое время до передачи товара Покупателю или получателю;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">в момент приемки товара от Доставщика;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">в иные сроки, указанные законом о защите прав потребителей.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">В случае отказа от товара надлежащего качества стоимость доставки не возвращается Покупателю.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель отдельно оплачивает стоимость доставки для возврата товара Продавцу Покупатель&nbsp; возвращаемого товара Продавцу.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец возвращает Покупателю денежные средства, уплаченные за товар, не позднее 30 дней с момента передачи товара на возврат за вычетом стоимости доставки для возврата.</span></li>
</ol>
<p style="line-height: 1.38; margin-left: 35.43307086614173pt; margin-top: 4pt; margin-bottom: 4pt;"><em><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Возврат товара ненадлежащего качества</span></em></p>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Не являются дефектами, которые дают Покупателю право отказаться от товара:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">наличие загрязнений на доставочной упаковке товара;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">несоответствие упаковки ожиданиям Покупателя;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">незначительное несовпадение оттенка и других внешних свойств товара изображениям в Карточке Товара.</span></li>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Ответственность</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">К отношениям, регулируемым Договором, применяются законодательство в сфере защиты прав потребителей.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Продавец </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">не несет ответственность за:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">ненадлежащее исполнение Договора, вызванное предоставлением Пользователем недостоверных данных;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">недостатки товара, возникшие после передачи товара для доставки Покупателю;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">последствия ненадлежащей эксплуатации товара (нарушения инструкции по эксплуатации), его самостоятельной сборки, ремонта;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">убытки, возникшие у Покупателя из-за получения третьими лицами доступа к его Профилю.</span></li>
</ol>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Покупатель несет ответственность за:</span></li>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">достоверность указанных в Заказе сведений об адресе доставки;</span></li>
<li aria-level="3"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">нарушение инструкции по эксплуатации и гарантийных условий.</span></li>
</ol>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Коммуникации</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Для обмена информацией по Заказу стороны используют чат Маркетплейса.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Иные способы связи с Продавцом размещены в его Магазине.&nbsp;</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Номер телефона, адрес местонахождения, электронный адрес и другие способы коммуникации указываются в Карточке товара или на странице Продавца.(запрещено 9.3)</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Порядок разрешения споров</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Претензионный порядок решения споров является обязательным. Срок ответа на претензию - 15 дней.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Споры с потребителями решаются в судебном порядке по месту нахождения Покупателя.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Применимое право &mdash; законодательство Российской Федерации.</span></li>
</ol>
</ol>
</ol>
<ul>
<li aria-level="1"><strong><span style="font-size: 11pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Действие Договора</span></strong></li>
</ul>
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<ol style="margin-top: 0; margin-bottom: 0; padding-inline-start: 48px;">
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Договор действует с момент заключения до момента полного исполнения сторонами своих обязательств.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Иные условия, не предусмотренные Договором, содержатся к Карточке Товара или согласуются при оформлении Заказа.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Частично и ограниченно дееспособный Покупатель акцептом заверяет Продавца о том, что у него есть письменное согласие законного представителя на заключение Договора.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: #ffffff; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Администратор вправе </span><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">вносить изменения в Договор, уведомляя об этом Покупателей и Продавцов через Профиль.</span></li>
<li aria-level="2"><span style="font-size: 10pt; font-family: Roboto,sans-serif; color: #000000; background-color: transparent; font-weight: 400; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;">Новая версия Договора вступает в силу с момента опубликования в Маркетплейсе. Новая версия Договора не распространяется на Заказы, оплаченные до ее опубликования.</span></li>
</ol>
</ol>
<p><br /><br /></p>
""";

class _ContractOfSale extends State<ContractOfSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Типовой договор купли-продажи',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: Html(data: htmlData)),
    );
  }
}
