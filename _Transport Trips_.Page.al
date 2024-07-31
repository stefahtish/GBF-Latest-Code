page 50391 "Transport Trips"
{
    PageType = ListPart;
    SourceTable = "Transport Trips";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    Enabled = NOT Requisition;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                    Enabled = Requisition;
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    Editable = false;
                    //Visible = "Vehicle Type" <> "Vehicle Type"::Taxi;
                }
                field("Vehicle Capacity"; Rec."Vehicle Capacity")
                {
                    Editable = false;
                }
                field(Driver; Rec.Driver)
                {
                    Enabled = Requisition;
                    //Editable = "Vehicle Type" <> "Vehicle Type"::Taxi;
                }
                field("Drivers Name"; Rec."Drivers Name")
                {
                    //Editable = "Vehicle Type" <> "Vehicle Type"::Taxi;
                }
                field("Previous KM"; Rec."Previous KM")
                {
                    Editable = false;
                }
                field("Time Out"; Rec."Time Out")
                {
                    Enabled = Requisition;
                }
                field("Time In"; Rec."Time In")
                {
                    Editable = NOT Requisition;
                }
                field("End of Journey KM"; Rec."End of Journey KM")
                {
                    Editable = NOT Requisition;
                }
                field("KM Driven"; Rec."KM Driven")
                {
                    Editable = false;
                }
                field("Litres of Oil"; Rec."Litres of Oil")
                {
                    Visible = false;
                }
                field("Litres of Fuel"; Rec."Litres of Fuel")
                {
                    Editable = false;
                    //Visible = "Vehicle Type" <> "Vehicle Type"::Taxi;
                }
                field("Order/Invoice/Cash/Voucher No."; Rec."Order/Invoice/Cash/Voucher No.")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        CheckEditability;
    end;

    trigger OnOpenPage()
    begin
        CheckEditability;
    end;

    var
        Requisition: Boolean;

    procedure CheckEditability(): Boolean
    var
        TravelReq: Record "Travel Requests";
    begin
        if TravelReq.Get(GetReqCode) then begin
            if TravelReq."Transport Status" = TravelReq."Transport Status"::Requisition then
                Requisition := true
            else
                Requisition := false;
        end;
    end;

    procedure GetReqCode(): Code[20]
    var
        TransportReq: Record "Travel Requests";
    begin
        exit(Rec."Request No");
    end;
}
