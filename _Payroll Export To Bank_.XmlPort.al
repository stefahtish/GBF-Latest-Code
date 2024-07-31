xmlport 50109 "Payroll Export To Bank"
{
    Caption = 'Export To Bank';
    Direction = Export;
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;
            Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textelement(CustomerRefNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerRefNo := 'Customer Ref No';
                    end;
                }
                textelement(BeneficiaryName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BeneficiaryName := 'Beneficiary Name';
                    end;
                }
                textelement(BeneficiaryBankCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BeneficiaryBankCode := 'Beneficiary Bank Code';
                    end;
                }
                textelement(BranchCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BranchCode := 'BranchCode'
                    end;
                }
                textelement(BeneficiaryAccNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BeneficiaryAccNo := 'Beneficiary Account No.'
                    end;
                }
                textelement(PaymentAmount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PaymentAmount := 'Payment Amount'
                    end;
                }
                textelement(TransactionTypeCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransactionTypeCode := 'Transaction Type Code'
                    end;
                }
                textelement(PurposeOfPayment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PurposeOfPayment := 'Purpose of Payment';
                    end;
                }
                textelement(BeneAddress)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BeneAddress := 'Bene address';
                    end;
                }
                textelement(ChargeType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ChargeType := 'Charge Type';
                    end;
                }
                textelement(TransactionCurrency)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransactionCurrency := 'Transaction Currency';
                    end;
                }
                textelement(PaymentType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PaymentType := 'Payment Type';
                    end;
                }
            }
            tableelement(Employee;
            Employee)
            {
                CalcFields = "Total Allowances", "Total Deductions", "Net Pay";
                RequestFilterFields = "No.", "Pay Period Filter";
                XmlName = 'Employees';
                SourceTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Active));

                fieldelement(No;
                Employee."No.")
                {
                }
                textelement(Name)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    end;
                }
                fieldelement(BankCode;
                Employee."Employee's Bank")
                {
                }
                fieldelement(BranchCode;
                Employee."Bank Branch")
                {
                }
                fieldelement(AcNo;
                Employee."Bank Account Number")
                {
                }
                fieldelement(Amount;
                Employee."Net Pay")
                {
                }
                textelement(TransTypeCode)
                {
                }
                textelement(PaymentPurpose)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PaymentPurpose := Format(Employee."Pay Period Filter", 0, '<Month,2><Year4>') + ' Salary';
                    end;
                }
                fieldelement(Address;
                Employee.Address)
                {
                }
                textelement(CType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CType := 'OUR';
                    end;
                }
                textelement(Currency)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Currency := 'KES';
                    end;
                }
                textelement(PayType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PayType := PType;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Employee.TestField("Employee's Bank");
                    Employee.TestField("Bank Branch");
                    Employee.TestField("Bank Account Number");
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(PType; PType)
                {
                    Caption = 'Pay Mode';
                    TableRelation = "Payment Method";
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    trigger OnPreXmlPort()
    begin
        if not Confirm(Text002, false) then exit;
        if PType = '' then Error('Please define Payment Type');
        PayPeriodFilter := Employee.GetFilter("Pay Period Filter");
        // IF Pensioners."Pay Period Filter" = 0D THEN
        //  ERROR(Text001);
    end;

    var
        PayrollPeriod: Code[20];
        NetPay: Decimal;
        PayDate: Date;
        Text001: Label 'Kindly specify pay period filter';
        Text002: Label 'Are you sure you want to generate this document';
        PayPeriodFilter: Text;
        PType: Code[20];
}
