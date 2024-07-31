page 51126 "Perfomance Target Lines"
{
    Caption = 'Sub-Indicators';
    PageType = ListPart;
    SourceTable = "Perfomance Targets Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field("Q1 Target"; Rec."Q1 Target")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Q2 Target"; Rec."Q2 Target")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Q3 Target"; Rec."Q3 Target")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Q4 Target"; Rec."Q4 Target")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Annual  Target"; Rec."Annual  Target")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
