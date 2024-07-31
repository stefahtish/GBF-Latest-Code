page 51225 "Annual Risk Setup"
{
    Caption = 'Risk Setup';
    PageType = List;
    SourceTable = "Annual Risk Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Quantifiable; Rec.Quantifiable)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlApperance();
                    end;
                }
                field("Value At risk"; Rec."Value At risk")
                {
                    Enabled = RQuantifiable;
                    ApplicationArea = All;
                }
                field(Probability; Rec.Probability)
                {
                    ApplicationArea = All;
                }
                field("Likelihood code"; Rec."Likelihood code")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Likelihood Score"; Rec."Likelihood Score")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Impact code"; Rec."Impact code")
                {
                    ApplicationArea = All;
                }
                field("Impact Score"; Rec."Impact Score")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Value After Control"; Rec."Value After Control")
                {
                    Enabled = RQuantifiable;
                    ApplicationArea = All;
                }
                field("Control Probability"; Rec."Control Probability")
                {
                    ApplicationArea = All;
                }
                field("Control Likelihood code"; Rec."Control Likelihood code")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Control Likelihood Score"; Rec."Control Likelihood Score")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Control Impact code"; Rec."Control Impact code")
                {
                    ApplicationArea = All;
                }
                field("Control Impact Score"; Rec."Control Impact Score")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlApperance();
    end;

    var
        RQuantifiable: Boolean;

    procedure SetControlApperance()
    var
        myInt: Integer;
    begin
        if Rec.Quantifiable = Rec.Quantifiable::Yes then
            RQuantifiable := true
        else
            RQuantifiable := false;
    end;
}
