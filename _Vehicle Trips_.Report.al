report 50195 "Vehicle Trips"
{
    DefaultLayout = RDLC;
    RDLCLayout = './VehicleTrips.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Travel Requests"; "Travel Requests")
        {
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(County; CompanyInfo.County)
            {
            }
            column(Request_No; "Travel Requests"."Request No.")
            {
            }
            column(Request_Date; "Travel Requests"."Request Date")
            {
            }
            column(Destination; "Travel Requests".Destinations)
            {
            }
            dataitem("Transport Trips"; "Transport Trips")
            {
                DataItemLink = "Request No" = FIELD("Request No.");
                RequestFilterFields = "Vehicle No";

                column(RequestNo; "Transport Trips"."Request No")
                {
                }
                column(Date; "Transport Trips".Date)
                {
                }
                column(Vehicle_No; "Transport Trips"."Vehicle No")
                {
                }
                column(Vehicle_Description; "Transport Trips"."Vehicle Description")
                {
                }
                column(Driver; "Transport Trips".Driver)
                {
                }
                column(Drivers_Name; "Transport Trips"."Drivers Name")
                {
                }
                column(Previous_KM; "Transport Trips"."Previous KM")
                {
                }
                column(Time_Out; "Transport Trips"."Time Out")
                {
                }
                column(Time_In; "Transport Trips"."Time In")
                {
                }
                column(End_of_Journey_KM; "Transport Trips"."End of Journey KM")
                {
                }
                column(KM_Driven; "Transport Trips"."KM Driven")
                {
                }
                column(Litres_of_Oil; "Transport Trips"."Litres of Oil")
                {
                }
                column(Litres_of_Fuel; "Transport Trips"."Litres of Fuel")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
