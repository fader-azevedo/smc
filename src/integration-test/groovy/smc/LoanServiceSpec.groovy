package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class LoanServiceSpec extends Specification {

    LoanService loanService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Loan(...).save(flush: true, failOnError: true)
        //new Loan(...).save(flush: true, failOnError: true)
        //Loan loan = new Loan(...).save(flush: true, failOnError: true)
        //new Loan(...).save(flush: true, failOnError: true)
        //new Loan(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //loan.id
    }

    void "test get"() {
        setupData()

        expect:
        loanService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Loan> loanList = loanService.list(max: 2, offset: 2)

        then:
        loanList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        loanService.count() == 5
    }

    void "test delete"() {
        Long loanId = setupData()

        expect:
        loanService.count() == 5

        when:
        loanService.delete(loanId)
        sessionFactory.currentSession.flush()

        then:
        loanService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Loan loan = new Loan()
        loanService.save(loan)

        then:
        loan.id != null
    }
}
