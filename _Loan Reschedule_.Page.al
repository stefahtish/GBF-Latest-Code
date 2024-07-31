page 50698 "Loan Reschedule"
{
    PageType = StandardDialog;
    SourceTable = "Loan Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Loan Details")
            {
                Caption = 'Original Loan Details';
                Editable = false;

                field("Loan No"; Rec."Loan No")
                {
                    Caption = 'Loan No.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Caption = 'Original Loan Amount';
                }
                field(Instalment; Rec.Instalment)
                {
                    Caption = 'Original No. of Installments';
                }
                field(Repayment; Rec.Repayment)
                {
                    Caption = 'Original Repayment Amount';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
            }
            group("New Loan Details")
            {
                field(NewRescheduleDate; NewRescheduleDate)
                {
                    Caption = 'Loan Reschedule Date';
                }
                field("Loan Balance"; LoanBal)
                {
                    Editable = false;
                }
                field(NewInstallments; NewInstallments)
                {
                    Caption = 'New Installments';

                    trigger OnValidate()
                    begin
                        Freq := GetFrequency;
                        GetLoanBal;
                        NewRepaymentAmt := CalculateLoanRepayment(NewInstallments, LoanBal);
                    end;
                }
                field(NewRepaymentAmt; NewRepaymentAmt)
                {
                    Caption = 'New Repayment Amount';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Total Repayment");
        GetLoanBal;
    end;

    trigger OnAfterGetRecord()
    begin
        NewRescheduleDate := Today;
        GetLoanBal;
    end;

    trigger OnInit()
    begin
        LoanBal := 0;
    end;

    trigger OnOpenPage()
    begin
        NewRescheduleDate := Today;
        GetLoanBal;
    end;

    var
        NewInstallments: Integer;
        NewRepaymentAmt: Decimal;
        NewRescheduleDate: Date;
        Freq: Decimal;
        LoanBal: Decimal;

    procedure GetRescheduleDetails(var NewInst: Integer; var NewRepAmt: Decimal; var RescheduleDate: Date; var Bal: Decimal)
    begin
        NewInst := NewInstallments;
        NewRepAmt := NewRepaymentAmt;
        RescheduleDate := NewRescheduleDate;
        Rec.CalcFields("Total Repayment");
        Bal := Rec."Approved Amount" + Rec."Total Repayment";
    end;

    local procedure GetFrequency() Frequency: Decimal
    begin
        case Rec."Repayment Frequency" of
            Rec."Repayment Frequency"::Monthly:
                Frequency := 1 / 12;
            Rec."Repayment Frequency"::Quaterly:
                Frequency := 3 / 12;
            Rec."Repayment Frequency"::"Semi-Annually":
                Frequency := 6 / 12;
            Rec."Repayment Frequency"::Annually:
                Frequency := 1;
        end;
    end;

    procedure CalculateLoanRepayment(NewInst: Integer; NewBal: Decimal) NewRepayment: Decimal
    var
        i: Decimal;
        LoanTypeRec: Record "Loan Product Type";
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Text;
    begin
        GetLoanBal;
        NewBal := 0;
        NewInst := 0;
        if LoanTypeRec.Get(Rec."Loan Product Type") then;
        LoanTypeRec.TestField("Rounding Precision");
        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;
        RoundPrecisionDec := LoanTypeRec."Rounding Precision";
        case Rec."Interest Calculation Method" of
            Rec."Interest Calculation Method"::Amortised:
                NewRepayment := Round((Rec."Interest Rate" / 12 / 100) / (1 - Power((1 + (Rec."Interest Rate" / 12 / 100)), -NewInst)) * NewBal, LoanTypeRec."Rounding Precision", RoundDirectionCode);
            Rec."Interest Calculation Method"::"Flat Rate":
                NewRepayment := Round((NewBal / NewInst) + Rec.FlatRateCalc(NewBal, Rec.Interest), LoanTypeRec."Rounding Precision", RoundDirectionCode);
            Rec."Interest Calculation Method"::"Reducing Balance":
                NewRepayment := Round(NewBal / NewInst, LoanTypeRec."Rounding Precision", RoundDirectionCode);
        end;
        exit(Rec.Repayment);
    end;

    local procedure GetLoanBal()
    begin
        Rec.CalcFields("Total Repayment");
        LoanBal := Rec."Approved Amount" + Rec."Total Repayment";
    end;
}
