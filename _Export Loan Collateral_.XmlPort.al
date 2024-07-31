xmlport 50110 "Export Loan Collateral"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
    textelement(RootNodeName)
    {
    tableelement(Integer;
    Integer)
    {
    XmlName = 'Header';
    SourceTableView = SORTING(Number)WHERE(Number=CONST(1));

    textelement(CollCode)
    {
    trigger OnBeforePassVariable()
    begin
        CollCode:='S.No';
    end;
    }
    textelement(CType)
    {
    trigger OnBeforePassVariable()
    begin
        CType:='Type';
    end;
    }
    textelement(CollValue)
    {
    trigger OnBeforePassVariable()
    begin
        CollValue:='Collateral Value';
    end;
    }
    textelement(CustAcc)
    {
    trigger OnBeforePassVariable()
    begin
        CustAcc:='Customers Loan Account No.';
    end;
    }
    textelement(Gender)
    {
    trigger OnBeforePassVariable()
    begin
        Gender:='Client Gender';
    end;
    }
    textelement(LoanDur)
    {
    trigger OnBeforePassVariable()
    begin
        LoanDur:='Original Loan Tenor (months)';
    end;
    }
    textelement(RemInst)
    {
    trigger OnBeforePassVariable()
    begin
        RemInst:='Remaining Loan Tenor (months)';
    end;
    }
    textelement(MatDate)
    {
    trigger OnBeforePassVariable()
    begin
        MatDate:='Maturity Date';
    end;
    }
    textelement(OutsBal)
    {
    trigger OnBeforePassVariable()
    begin
        OutsBal:='Loan Outstanding Balance (Kshs)';
    end;
    }
    textelement(LoanArrears)
    {
    trigger OnBeforePassVariable()
    begin
        LoanArrears:='Loan Arrears Balance(Kshs)';
    end;
    }
    textelement(DaysInArrears)
    {
    trigger OnBeforePassVariable()
    begin
        DaysInArrears:='Days in Arrears (Kshs)';
    end;
    }
    textelement(LastPayDate)
    {
    trigger OnBeforePassVariable()
    begin
        LastPayDate:='Date last instalment received';
    end;
    }
    textelement(LoanInstAmt)
    {
    trigger OnBeforePassVariable()
    begin
        LoanInstAmt:='Loan Instalment Amount (Kshs)';
    end;
    }
    textelement(LRepFreq)
    {
    trigger OnBeforePassVariable()
    begin
        LRepFreq:='Loan Repayment Frequency';
    end;
    }
    textelement(IntRate)
    {
    trigger OnBeforePassVariable()
    begin
        IntRate:='Interest Rate %';
    end;
    }
    textelement(PropValue)
    {
    trigger OnBeforePassVariable()
    begin
        PropValue:='Current Property Value (latest)' end;
    }
    textelement(PRefNo)
    {
    trigger OnBeforePassVariable()
    begin
        PRefNo:='Land Ref No.';
    end;
    }
    textelement(County)
    {
    trigger OnBeforePassVariable()
    begin
        County:='Client County';
    end;
    }
    textelement(Disable)
    {
    trigger OnBeforePassVariable()
    begin
        Disable:='Disability';
    end;
    }
    }
    }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var LoanNo: Code[50];
}
