page 50674 "Earning & Deductions Header"
{
    PageType = Card;
    SourceTable = "Import Earn & Ded Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field(No; Rec.No)
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Pay Period"; Rec."Pay Period")
                {
                }
                field("Pay Period Text"; Rec."Pay Period Text")
                {
                    Editable = false;
                }
                field(Total; Rec.Total)
                {
                    Caption = 'Batch Total';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control4; "Earning & Deduction Lines")
            {
                SubPageLink = No = FIELD(No);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Import Earnings & Deductions")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.TestField(Code);
                    Rec.TestField("Pay Period");
                    Clear("Earn&Ded");
                    "Earn&Ded".GetNoSeries(Rec);
                    //"Earn&Ded".NegateDed(Rec);
                    "Earn&Ded".Run;
                end;
            }
            action(Post)
            {
                Caption = 'P&ost';
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to update the %1 - %2 for Period %3?', true, Rec.Code, Rec.Description, Rec."Pay Period") = false then begin
                        exit
                    end;
                    Rec.TestField(Code);
                    Rec.TestField("Pay Period");
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.FindFirst then begin
                        if Rec."Pay Period" <> PayPeriod."Starting Date" then begin
                            if Rec."Pay Period" > PayPeriod."Starting Date" then Error('Kindly close the previous periods before Posting')
                        end;
                    end;
                    if PayPeriod.Get(Rec."Pay Period") then begin
                        if PayPeriod.Closed = true then Error('The specified period %1 is closed', Rec."Pay Period");
                    end;
                    PayrollMgt.InsertAssignMatrix(Rec);
                    Rec.Status := Rec.Status::Released;
                    Message('The %1 %2-%3 have been updated Successfully for the Period %4', Rec.Type, Rec.Code, Rec.Description, Rec."Pay Period Text");
                    CurrPage.Close;
                end;
            }
        }
    }
    var
        "Earn&Ded": XMLport "Import Earnings & Deductions";
        PayrollMgt: Codeunit Payroll;
        PayPeriod: Record "Payroll PeriodX";
}
