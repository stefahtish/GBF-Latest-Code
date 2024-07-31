page 51466 "Committe Member Setup"
{
    Caption = 'Committe Member Setup';
    PageType = Card;
    SourceTable = "Committee Members Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit then CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Members; Rec.Members)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Members field.';
                }
            }
            part("Committee Member Lines"; "Committee Member Lines")
            {
                Caption = 'Committee Members';
                SubPageLink = "Batch No." = FIELD("No.");
                UpdatePropagation = both;
            }
        }
    }
    procedure AssistEdit(): Boolean
    begin
        HRSetup.Get;
        HRSetup.TestField("Committee Nos");
        if NoSeriesMgt.SelectSeries(HRSetup."Committee Nos", xRec."No. Series", Rec."No. Series") then begin
            NoSeriesMgt.SetSeries(Rec."No.");
            exit(true);
        end;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
