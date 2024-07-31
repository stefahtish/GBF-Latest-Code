page 51014 "Compliance Products Setup"
{
    Caption = 'Compliance Products Setup';
    PageType = List;
    SourceTable = "Dairy Produce Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dairy Produce"; Rec."Dairy Produce")
                {
                    ApplicationArea = All;
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                }
                field(Type; Rec.Type)
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetcontrolAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Heading; Rec.Heading)
                {
                    Enabled = HeadingVisible;
                }
                // field(Others; Others)
                // {
                //     trigger OnValidate()
                //     begin
                //         if Others = true then begin
                //             OtherTrue := true;
                //         end else begin
                //             OtherTrue := false;
                //         end;
                //     end;
                // }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetcontrolAppearance();
    end;

    var
        HeadingVisible: Boolean;

    procedure SetcontrolAppearance()
    begin
        if Rec.Type = Rec.Type::SubHeading then
            HeadingVisible := true
        else
            HeadingVisible := false;
    end;

    var
        OtherTrue: Boolean;
}
