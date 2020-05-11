package smc

import auth.Role
import auth.User
import auth.UserRole
import groovy.json.JsonSlurper

class BootStrap {

    def init = { servletContext ->
        if(Settings.count == 0){
            def root = 'C:/Dropbox/SMC'
            new Settings(root: root,logo: 'logo,jpg',loans: 'Emprestimos',ano: Calendar.getInstance().get(Calendar.YEAR)).save()
            new File(root).mkdirs()
        }

        def adminRole = Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        def userRole = Role.findOrSaveWhere(authority: 'ROLE_USER')

        if(User.count == 0) {
            def admin = User.findByUsername('admin')
            if (!admin) {
                admin = new User(username: 'admin', password: 'admin', fullName: 'ADMIN', cellphone: '123456789'
                        , address: 'Admin Address', email: 'admin@gmai.com'
                ).save()
            }

            def user = User.findByUsername('user')
            if (!user) {
                user = new User(username: 'user', password: 'user', fullName: 'User', cellphone: '987654321'
                        , address: 'User Address', email: 'user@gmai.com'
                ).save()
            }

            if (!UserRole.findByUserAndRole(admin, adminRole)) {
                new UserRole(user: admin, role: adminRole).save()
            }
            if (!UserRole.findByUserAndRole(user, userRole)) {
                new UserRole(user: user, role: userRole).save()
            }
        }

        if(InstalmentType.count == 0){
            ['Renda Normal', 'Parcela', 'Taxa de Concessão', 'Multa'].each {
                InstalmentType.findOrSaveWhere(name: it)
            }
        }

        if(DocumentType.count == 0) {
            ['BI', 'Passaporte', 'Carta de Condução', 'Talão de BI', 'DIRE'].each {
                DocumentType.findOrSaveWhere(name: it)
            }
        }

        if(PaymentMode.count == 0){
            ['Diaria','Semanal','Quinzenal','Mensal'].each {
                PaymentMode.findOrSaveWhere(name: it)
            }
        }

        if(Province.count == 0) {
            new JsonSlurper().parseText(provinces).each {
                Province.findOrSaveWhere(id: new Long(it.id), name: it.name)
            }

            new JsonSlurper().parseText(districts).each {
                District.findOrSaveWhere(id: new Long(it.id), name: it.name, province: Province.get(new Long(it.province_id)))
            }
        }

        if(GuaranteeType.count == 0){
            new JsonSlurper().parseText(guaranteeTypeJSON).each {
                GuaranteeType.findOrSaveWhere(name: it.name)
            }
        }
    }
    
    def guaranteeTypeJSON = '[\n' +
            '{"name":"Carro"},\n' +
            '{"name":"Congelador"},\n' +
            '{"name":"Geleira"},\n' +
            '{"name":"Televisão"},\n' +
            '{"name":"Computador"},\n' +
            '{"name":"Maquina"},\n' +
            '{"name":"Micro-Ondas"},\n' +
            '{"name":"Mesa"},\n' +
            '{"name":"Terreno"},\n' +
            '{"name":"Fogão"},\n' +
            '{"name":"Estante"},\n' +
            '{"name":"Sistema de Som"},\n' +
            '{"name":"Cadeiras"},\n' +
            '{"name":"Amplificador"}]'

    def provinces = '[\n' +
            '{"id":"1","name":"Cabo Delgado"},\n' +
            '{"id":"2","name":"Cidade de Maputo"},\n' +
            '{"id":"3","name":"Gaza"},\n' +
            '{"id":"4","name":"Inhambane"},\n' +
            '{"id":"5","name":"Manica"},\n' +
            '{"id":"6","name":"Maputo"},\n' +
            '{"id":"7","name":"Nampula"},\n' +
            '{"id":"8","name":"Niassa"},\n' +
            '{"id":"9","name":"Sofala"},\n' +
            '{"id":"10","name":"Tete"},\n' +
            '{"id":"11","name":"Zambézia"}\n' +
            ']'

    def districts = '[\n' +
            '{"id":"1","province_id":"1","name":"Ancuabe"},\n' +
            '{"id":"2","province_id":"1","name":"Balama"},\n' +
            '{"id":"3","province_id":"1","name":"Chiúre"},\n' +
            '{"id":"4","province_id":"1","name":"Ibo"},\n' +
            '{"id":"5","province_id":"1","name":"Macomia"},\n' +
            '{"id":"6","province_id":"1","name":"Mecúfi"},\n' +
            '{"id":"7","province_id":"1","name":"Meluco"},\n' +
            '{"id":"8","province_id":"1","name":"Mocímboa da Praia"},\n' +
            '{"id":"9","province_id":"1","name":"Montepuez"},\n' +
            '{"id":"10","province_id":"1","name":"Mueda"},\n' +
            '{"id":"11","province_id":"1","name":"Muidumbe"},\n' +
            '{"id":"12","province_id":"1","name":"Namuno"},\n' +
            '{"id":"13","province_id":"1","name":"Nangade"},\n' +
            '{"id":"14","province_id":"1","name":"Palma"},\n' +
            '{"id":"15","province_id":"1","name":"Pemba-Metuge"},\n' +
            '{"id":"16","province_id":"1","name":"Quissanga"},\n' +
            '{"id":"17","province_id":"2","name":"Distrito Urbano de Nlhamankulu"},\n' +
            '{"id":"18","province_id":"2","name":"Distrito Urbano de KaMaxaquene"},\n' +
            '{"id":"19","province_id":"2","name":"Distrito Urbano de KaMavota"},\n' +
            '{"id":"20","province_id":"2","name":"Distrito Municipal de KaMubukwane"},\n' +
            '{"id":"21","province_id":"2","name":"Distrito Municipal de KaTembe"},\n' +
            '{"id":"22","province_id":"2","name":"Distrito Municipal de KaNyaka"},\n' +
            '{"id":"23","province_id":"3","name":"Bilene Macia"},\n' +
            '{"id":"24","province_id":"3","name":"Chibuto"},\n' +
            '{"id":"25","province_id":"3","name":"Chicualacuala"},\n' +
            '{"id":"26","province_id":"3","name":"Chigubo"},\n' +
            '{"id":"27","province_id":"3","name":"Chókwè"},\n' +
            '{"id":"28","province_id":"3","name":"Guijá"},\n' +
            '{"id":"29","province_id":"3","name":"Mabalane"},\n' +
            '{"id":"30","province_id":"3","name":"Manjacaze"},\n' +
            '{"id":"31","province_id":"3","name":"Massangena"},\n' +
            '{"id":"32","province_id":"3","name":"Massingir"},\n' +
            '{"id":"33","province_id":"3","name":"Xai-Xai"},\n' +
            '{"id":"34","province_id":"4","name":"Funhalouro"},\n' +
            '{"id":"35","province_id":"4","name":"Govuro"},\n' +
            '{"id":"36","province_id":"4","name":"Homoíne"},\n' +
            '{"id":"37","province_id":"4","name":"Inharrime"},\n' +
            '{"id":"38","province_id":"4","name":"Inhassoro"},\n' +
            '{"id":"39","province_id":"4","name":"Jangamo"},\n' +
            '{"id":"40","province_id":"4","name":"Mabote"},\n' +
            '{"id":"41","province_id":"4","name":"Massinga"},\n' +
            '{"id":"42","province_id":"4","name":"Cidade de Maxixe"},\n' +
            '{"id":"43","province_id":"4","name":"Morrumbene"},\n' +
            '{"id":"44","province_id":"4","name":"Panda"},\n' +
            '{"id":"45","province_id":"4","name":"Vilanculos"},\n' +
            '{"id":"46","province_id":"4","name":"Zavala"},\n' +
            '{"id":"47","province_id":"5","name":"Bárue"},\n' +
            '{"id":"48","province_id":"5","name":"Cidade de  Chimoio"},\n' +
            '{"id":"49","province_id":"5","name":"Gondola"},\n' +
            '{"id":"50","province_id":"5","name":"Macate"},\n' +
            '{"id":"51","province_id":"5","name":"[[Vanduzi (distrito)|Vanduzi]"},\n' +
            '{"id":"52","province_id":"5","name":"Guro"},\n' +
            '{"id":"53","province_id":"5","name":"Mossurize"},\n' +
            '{"id":"54","province_id":"5","name":"Machaze"},\n' +
            '{"id":"55","province_id":"5","name":"Macossa"},\n' +
            '{"id":"56","province_id":"5","name":"Manica"},\n' +
            '{"id":"57","province_id":"5","name":"Vanduzi"},\n' +
            '{"id":"58","province_id":"5","name":"Sussundenga"},\n' +
            '{"id":"59","province_id":"5","name":"Tambara"},\n' +
            '{"id":"60","province_id":"6","name":"Matola"},\n' +
            '{"id":"61","province_id":"6","name":"Boane"},\n' +
            '{"id":"62","province_id":"6","name":"Magude"},\n' +
            '{"id":"63","province_id":"6","name":"Manhiça"},\n' +
            '{"id":"64","province_id":"6","name":"Marracuene"},\n' +
            '{"id":"65","province_id":"6","name":"Matutuíne"},\n' +
            '{"id":"66","province_id":"6","name":"Moamba"},\n' +
            '{"id":"67","province_id":"6","name":"Namaacha"},\n' +
            '{"id":"68","province_id":"7","name":"Cidade de Nampula"},\n' +
            '{"id":"69","province_id":"7","name":"Angoche"},\n' +
            '{"id":"70","province_id":"7","name":"Eráti"},\n' +
            '{"id":"71","province_id":"7","name":"Ilha de Mocambique"},\n' +
            '{"id":"72","province_id":"7","name":"Lalaua"},\n' +
            '{"id":"73","province_id":"7","name":"Malema"},\n' +
            '{"id":"74","province_id":"7","name":"Meconta"},\n' +
            '{"id":"75","province_id":"7","name":"Mecubúri"},\n' +
            '{"id":"76","province_id":"7","name":"Memba"},\n' +
            '{"id":"77","province_id":"7","name":"Mogincual"},\n' +
            '{"id":"78","province_id":"7","name":"Mogovolas"},\n' +
            '{"id":"79","province_id":"7","name":"Moma"},\n' +
            '{"id":"80","province_id":"7","name":"Monapo"},\n' +
            '{"id":"81","province_id":"7","name":"Mossuril"},\n' +
            '{"id":"82","province_id":"7","name":"Muecate"},\n' +
            '{"id":"83","province_id":"7","name":"Murrupula"},\n' +
            '{"id":"84","province_id":"7","name":"Cidade de Nacala Porto"},\n' +
            '{"id":"85","province_id":"7","name":"Nacala-a-Velha"},\n' +
            '{"id":"86","province_id":"7","name":"Nacarôa"},\n' +
            '{"id":"87","province_id":"7","name":"Rapale"},\n' +
            '{"id":"88","province_id":"7","name":"Ribaué"},\n' +
            '{"id":"89","province_id":"8","name":"Cuamba"},\n' +
            '{"id":"90","province_id":"8","name":"Lago"},\n' +
            '{"id":"91","province_id":"8","name":"Lichinga"},\n' +
            '{"id":"92","province_id":"8","name":"Majune"},\n' +
            '{"id":"93","province_id":"8","name":"Mandimba"},\n' +
            '{"id":"94","province_id":"8","name":"Marrupa"},\n' +
            '{"id":"95","province_id":"8","name":"Maúa"},\n' +
            '{"id":"96","province_id":"8","name":"Mavago"},\n' +
            '{"id":"97","province_id":"8","name":"Mecanhelas"},\n' +
            '{"id":"98","province_id":"8","name":"Mecula"},\n' +
            '{"id":"99","province_id":"8","name":"Metarica"},\n' +
            '{"id":"100","province_id":"8","name":"Muembe"},\n' +
            '{"id":"101","province_id":"8","name":"N\'gauma"},\n' +
            '{"id":"102","province_id":"8","name":"Nipepe"},\n' +
            '{"id":"103","province_id":"8","name":"Sanga"},\n' +
            '{"id":"104","province_id":"9","name":"Cidade de  Beira"},\n' +
            '{"id":"105","province_id":"9","name":"Búzi"},\n' +
            '{"id":"106","province_id":"9","name":"Caia"},\n' +
            '{"id":"107","province_id":"9","name":"Chemba"},\n' +
            '{"id":"108","province_id":"9","name":"Cheringoma"},\n' +
            '{"id":"109","province_id":"9","name":"Chibabava"},\n' +
            '{"id":"110","province_id":"9","name":"Dondo"},\n' +
            '{"id":"111","province_id":"9","name":"Gorongosa"},\n' +
            '{"id":"112","province_id":"9","name":"Machanga"},\n' +
            '{"id":"113","province_id":"9","name":"Maringué"},\n' +
            '{"id":"114","province_id":"9","name":"Marromeu"},\n' +
            '{"id":"115","province_id":"9","name":"Muanza"},\n' +
            '{"id":"116","province_id":"9","name":"Nhamatanda"},\n' +
            '{"id":"117","province_id":"10","name":"Angónia"},\n' +
            '{"id":"118","province_id":"10","name":"Cahora-Bassa"},\n' +
            '{"id":"119","province_id":"10","name":"Changara"},\n' +
            '{"id":"120","province_id":"10","name":"Chifunde"},\n' +
            '{"id":"121","province_id":"10","name":"Chiuta"},\n' +
            '{"id":"122","province_id":"10","name":"Macanga"},\n' +
            '{"id":"123","province_id":"10","name":"Magoé"},\n' +
            '{"id":"124","province_id":"10","name":"Marávia"},\n' +
            '{"id":"125","province_id":"10","name":"Moatize"},\n' +
            '{"id":"126","province_id":"10","name":"Mutarara"},\n' +
            '{"id":"127","province_id":"10","name":"Tsangano"},\n' +
            '{"id":"128","province_id":"10","name":"Zumbo"},\n' +
            '{"id":"129","province_id":"11","name":"Alto Molócue"},\n' +
            '{"id":"130","province_id":"11","name":"Chinde"},\n' +
            '{"id":"131","province_id":"11","name":"Gilé"},\n' +
            '{"id":"132","province_id":"11","name":"Gurué"},\n' +
            '{"id":"133","province_id":"11","name":"Ile"},\n' +
            '{"id":"134","province_id":"11","name":"Inhassunge"},\n' +
            '{"id":"135","province_id":"11","name":"Lugela"},\n' +
            '{"id":"136","province_id":"11","name":"Maganja da Costa"},\n' +
            '{"id":"137","province_id":"11","name":"Milange"},\n' +
            '{"id":"138","province_id":"11","name":"Mocuba"},\n' +
            '{"id":"139","province_id":"11","name":"Mopeia"},\n' +
            '{"id":"140","province_id":"11","name":"Morrumbala"},\n' +
            '{"id":"141","province_id":"11","name":"Namacurra"},\n' +
            '{"id":"142","province_id":"11","name":"Namarroi"},\n' +
            '{"id":"143","province_id":"11","name":"Nicoadala"},\n' +
            '{"id":"144","province_id":"11","name":"Pebane"},\n' +
            '{"id":"145","province_id":"1","name":"Teste D"},\n' +
            '{"id":"146","province_id":"2","name":"Distrito KaMpfumo"}]'


    def destroy = {
    }
}
